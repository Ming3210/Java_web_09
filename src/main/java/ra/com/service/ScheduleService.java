package ra.com.service;

import ra.com.model.Schedule;

import java.util.List;

public interface ScheduleService {
    List<Schedule> findAllByMovieId(int movieId);

}
