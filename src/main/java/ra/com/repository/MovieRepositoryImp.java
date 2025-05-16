package ra.com.repository;

import org.springframework.stereotype.Repository;
import ra.com.model.Movie;
import ra.com.utils.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
@Repository
public class MovieRepositoryImp implements MovieRepository{
    @Override
    public List<Movie> getPaginatedMovies(int page, int size) {
        Connection conn = null;
        CallableStatement callableStatement = null;
        List<Movie> movieList = new ArrayList<>();
        try {
            conn = new ConnectionDB().openConnection();
            String sql = "{call get_paginated_movies(?,?)}";
            callableStatement = conn.prepareCall(sql);
            callableStatement.setInt(1, page);
            callableStatement.setInt(2, size);

            ResultSet resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                Movie movie = new Movie();
                movie.setId(resultSet.getInt("id"));
                movie.setTitle(resultSet.getString("title"));
                movie.setDirector(resultSet.getString("director"));
                movie.setGenre(resultSet.getString("genre"));
                movie.setDescription(resultSet.getString("description"));
                movie.setDuration(resultSet.getInt("duration"));
                movie.setLanguage(resultSet.getString("language"));

                movieList.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            ConnectionDB.closeConnection(conn, callableStatement);
        }
        return movieList;
    }

    @Override
    public int getTotalPages(int pageSize) {
        Connection conn = null;
        CallableStatement callableStatement = null;
        int totalPages = 0;
        try {
            conn = new ConnectionDB().openConnection();
            String sql = "{call get_total_pages(?, ?)}";
            callableStatement = conn.prepareCall(sql);
            callableStatement.setInt(1, pageSize);
            callableStatement.registerOutParameter(2, java.sql.Types.INTEGER);
            callableStatement.execute();
            totalPages = callableStatement.getInt(2);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(conn, callableStatement);
        }
        return totalPages;
    }

    @Override
    public Movie getMovieById(int id) {
        Connection conn = null;
        CallableStatement callableStatement = null;
        Movie movie = null;
        ResultSet rs = null;
        try {
            conn = new ConnectionDB().openConnection();
            callableStatement = conn.prepareCall( "{call get_movie_details(?)}");
            callableStatement.setInt(1, id);
            rs = callableStatement.executeQuery();

            if (rs.next()) {
                movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setDirector(rs.getString("director"));
                movie.setGenre(rs.getString("genre"));
                movie.setDescription(rs.getString("description"));
                movie.setDuration(rs.getInt("duration"));
                movie.setLanguage(rs.getString("language"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(conn, callableStatement);
        }
        return movie;
    }

}
