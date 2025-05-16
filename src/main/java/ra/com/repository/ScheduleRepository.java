package ra.com.repository;

import ra.com.model.Schedule;

import java.util.List;

public interface ScheduleRepository {
    List<Schedule> findAllByMovieId(int movieId);
}
