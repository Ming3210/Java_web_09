package ra.com.service;

import ra.com.model.Movie;

import java.util.List;

public interface MovieService {
    List<Movie> getPaginatedMovies(int page, int size);
    int getTotalPages(int pageSize);
    Movie getMovieById(int id);
}
