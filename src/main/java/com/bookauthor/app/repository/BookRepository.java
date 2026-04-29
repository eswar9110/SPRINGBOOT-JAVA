package com.bookauthor.app.repository;

import com.bookauthor.app.dto.BookAuthorDTO;
import com.bookauthor.app.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for Book entity.
 * Provides standard CRUD operations and a custom inner join query.
 */
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {

    /**
     * Custom query method that performs an INNER JOIN between Book and Author
     * entities and returns the combined result as BookAuthorDTO objects.
     *
     * @return List of BookAuthorDTO containing joined data from both entities
     */
    @Query("SELECT new com.bookauthor.app.dto.BookAuthorDTO(" +
           "b.title, b.isbn, b.price, b.yearPublished, a.name, a.email) " +
           "FROM Book b INNER JOIN b.author a")
    List<BookAuthorDTO> findAllBooksWithAuthors();

    /**
     * Find a book by its ISBN.
     * @param isbn the ISBN to search for
     * @return the Book with the given ISBN, or null if not found
     */
    Book findByIsbn(String isbn);
}
