package ra.com.repository;

import org.springframework.stereotype.Repository;
import ra.com.model.Schedule;
import ra.com.utils.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
@Repository
public class ScheduleRepositoryImp implements ScheduleRepository{

    @Override
    public List<Schedule> findAllByMovieId(int movieId) {
        Connection conn = null;
        List<Schedule> scheduleList = new ArrayList<>();
        ResultSet rs = null;
        CallableStatement callableStatement = null;
        try {
            conn = new ConnectionDB().openConnection();
            String sql = "{call get_schedules_by_movie_id(?)}";
            callableStatement = conn.prepareCall(sql);
            callableStatement.setLong(1, movieId);
            rs = callableStatement.executeQuery();

            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setMovieId(rs.getInt("movie_id"));
                schedule.setShowTime(rs.getDate("show_time"));
                schedule.setScreenRoomId(rs.getLong("screen_room_id"));
                schedule.setAvailableSeats(rs.getInt("available_seats"));
                schedule.setFormat(rs.getString("format"));

                scheduleList.add(schedule);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(conn, callableStatement);
        }
        return scheduleList;
    }
}
