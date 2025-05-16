package ra.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ra.com.model.Schedule;
import ra.com.repository.ScheduleRepository;

import java.util.List;
@Service
public class ScheduleServiceImp implements ScheduleService{
    @Autowired
    private ScheduleRepository scheduleRepository;
    @Override
    public List<Schedule> findAllByMovieId(int movieId) {
        return scheduleRepository.findAllByMovieId(movieId);
    }
}
