package ra.com.repository;

import org.springframework.stereotype.Repository;
import ra.com.model.Seat;
import ra.com.model.Ticket;
import ra.com.utils.ConnectionDB;

import java.sql.*;

@Repository
public class TicketRepositoryImp implements TicketRepository {
    @Override
    public boolean addTicket(Ticket ticket) {
        Connection conn = null;
        CallableStatement callableStatement = null;
        try {
            conn = ConnectionDB.openConnection();
            if (conn == null) {
                System.err.println("Database connection failed");
                return false;
            }

            String call = "{CALL create_ticket(?, ?, ?, ?, ?)}";
            callableStatement = conn.prepareCall(call);
            callableStatement.setLong(1, ticket.getCustomerId());
            callableStatement.setLong(2, ticket.getScheduleId());
            callableStatement.setDouble(3, ticket.getTotalMoney());
            callableStatement.setDate(4, Date.valueOf(ticket.getCreatedAt()));
            callableStatement.registerOutParameter(5, Types.BIGINT);

            callableStatement.executeUpdate();

            long ticketId = callableStatement.getLong(5);

            // Process seats
            for (Seat seat : ticket.getListSeat()) {
                try (CallableStatement csSeat = conn.prepareCall("{CALL add_ticket_seat(?, ?)}")) {
                    csSeat.setLong(1, ticketId);
                    csSeat.setLong(2, seat.getId());
                    csSeat.executeUpdate();
                }

                try (PreparedStatement psUpdateSeat = conn.prepareStatement(
                        "UPDATE seats SET status = 'BOOKED' WHERE id = ?")) {
                    psUpdateSeat.setInt(1, seat.getId());
                    psUpdateSeat.executeUpdate();
                }
            }

            // Update available seats in schedules table
            try (PreparedStatement psUpdateSchedule = conn.prepareStatement(
                    "UPDATE schedules SET available_seats = available_seats - ? WHERE id = ?")) {
                psUpdateSchedule.setInt(1, ticket.getListSeat().size());
                psUpdateSchedule.setLong(2, ticket.getScheduleId());
                psUpdateSchedule.executeUpdate();
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            ConnectionDB.closeConnection(conn, callableStatement);
        }
    }
}