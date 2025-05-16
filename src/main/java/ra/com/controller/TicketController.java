package ra.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ra.com.model.Seat;
import ra.com.model.SeatStatus;
import ra.com.model.Ticket;
import ra.com.service.TicketService;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/tickets")
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @PostMapping("/book")
    public String bookTicket(HttpServletRequest request, Model model) {
        try {
            // Check if parameters exist before parsing
            String customerIdStr = request.getParameter("customerId");
            String scheduleIdStr = request.getParameter("scheduleId");
            String[] selectedSeats = request.getParameterValues("seats");

            // Debug information
            System.out.println("customerId: " + customerIdStr);
            System.out.println("scheduleId: " + scheduleIdStr);
            System.out.println("selectedSeats: " + (selectedSeats != null ? selectedSeats.length : "null"));

            // Validate inputs
            if (customerIdStr == null || customerIdStr.trim().isEmpty() ||
                    scheduleIdStr == null || scheduleIdStr.trim().isEmpty() ||
                    selectedSeats == null || selectedSeats.length == 0) {

                model.addAttribute("message", "Thiếu thông tin đặt vé! Vui lòng chọn ít nhất một ghế.");
                return "ticket-result";
            }

            Long customerId = Long.parseLong(customerIdStr.trim());
            Long scheduleId = Long.parseLong(scheduleIdStr.trim());

            List<Seat> seats = new ArrayList<>();
            double totalMoney = 0;

            for (String seatIdStr : selectedSeats) {
                if (seatIdStr != null && !seatIdStr.trim().isEmpty()) {
                    int seatId = Integer.parseInt(seatIdStr.trim());

                    Seat seat = new Seat();
                    seat.setId(seatId);
                    seat.setPrice(50000.0);
                    seat.setStatus(SeatStatus.BOOKED);
                    seats.add(seat);
                    totalMoney += seat.getPrice();
                }
            }

            // Validate if seats were selected
            if (seats.isEmpty()) {
                model.addAttribute("message", "Bạn chưa chọn ghế nào!");
                return "ticket-result";
            }

            Ticket ticket = new Ticket();
            ticket.setCustomerId(customerId);
            ticket.setScheduleId(scheduleId);
            ticket.setListSeat(seats);
            ticket.setTotalMoney(totalMoney);
            ticket.setCreatedAt(LocalDate.now());

            boolean result = ticketService.addTicket(ticket);

            if (result) {
                model.addAttribute("message", "Đặt vé thành công!");
            } else {
                model.addAttribute("message", "Đặt vé thất bại!");
            }
        } catch (NumberFormatException e) {
            model.addAttribute("message", "Lỗi xử lý: Dữ liệu không hợp lệ: " + e.getMessage());
        } catch (Exception e) {
            model.addAttribute("message", "Lỗi xử lý: " + e.getMessage());
            e.printStackTrace();
        }

        return "ticket-result";
    }
}
