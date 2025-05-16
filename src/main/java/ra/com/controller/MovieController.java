package ra.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import ra.com.model.Movie;
import ra.com.model.Schedule;
import ra.com.service.MovieService;
import ra.com.service.ScheduleService;

import java.util.List;

@Controller
public class MovieController {

    @Autowired
    private MovieService movieService;
    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("/home")
    public String showMovies(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {

        int pageSize = 5;

        int totalPages = movieService.getTotalPages(pageSize);

        model.addAttribute("movies", movieService.getPaginatedMovies(page, pageSize));

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "home";
    }


    @GetMapping("/movies/{id}")
    public String viewMovieDetail(@PathVariable("id") int id, Model model) {
        Movie movie = movieService.getMovieById(id);
        List<Schedule> schedules = scheduleService.findAllByMovieId(id);

        model.addAttribute("movie", movie);
        model.addAttribute("schedules", schedules);

        return "movie-detail";
    }

}
