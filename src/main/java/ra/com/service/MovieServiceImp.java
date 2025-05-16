package ra.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ra.com.model.Movie;
import ra.com.repository.MovieRepository;

import java.util.List;
@Service
public class MovieServiceImp implements MovieService{

    @Autowired
    private MovieRepository movieRepository;
    @Override
    public List<Movie> getPaginatedMovies(int page, int size) {
        return movieRepository.getPaginatedMovies(page, size);
    }

    @Override
    public int getTotalPages(int pageSize) {
        return movieRepository.getTotalPages(pageSize);
    }

    @Override
    public Movie getMovieById(int id) {
        return movieRepository.getMovieById(id);
    }
}
