package ra.com.repository;

import ra.com.model.Movie;

import java.util.List;

public interface MovieRepository {
    List<Movie> getPaginatedMovies(int page, int size);
    int getTotalPages(int pageSize);
    Movie getMovieById(int id);
}
