package ra.com.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Ticket {
    private Long id;
    private Long customerId;
    private Long scheduleId;
    private List<Seat> listSeat;
    private Double totalMoney;
    private LocalDate createdAt;
}
