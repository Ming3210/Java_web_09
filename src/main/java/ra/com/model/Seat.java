package ra.com.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Seat {
    private int id;
    private Long screenRoomId;
    private Double price;
    private SeatStatus status;
}
