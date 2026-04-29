package com.bookauthor.app.service;

import com.bookauthor.app.dto.BookAuthorDTO;
import com.bookauthor.app.model.Book;
import com.bookauthor.app.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Book entity.
 * Handles business logic and integrates with the BookRepository.
 */
@Service
public class BookService {

    private final BookRepository bookRepository;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    /**
     * Retrieve all books from the database.
     * @return List of all books
     */
    public List<Book> findAll() {
        return bookRepository.findAll();
    }

    /**
     * Find a book by its ID.
     * @param id the book's ID
     * @return Optional containing the book if found
     */
    public Optional<Book> findById(Long id) {
        return bookRepository.findById(id);
    }

    /**
     * Save a new book to the database.
     * @param book the book to save
     * @return the saved book
     * @throws DataIntegrityViolationException if ISBN already exists
     */
    public Book save(Book book) throws DataIntegrityViolationException {
        return bookRepository.save(book);
    }

    /**
     * Update an existing book's details.
     * @param id the ID of the book to update
     * @param updatedBook the updated book data
     * @return the updated book
     * @throws RuntimeException if book not found
     * @throws DataIntegrityViolationException if ISBN already exists
     */
    public Book update(Long id, Book updatedBook) throws DataIntegrityViolationException {
        Optional<Book> existingOpt = bookRepository.findById(id);
        if (!existingOpt.isPresent()) {
            throw new RuntimeException("Book not found with id: " + id);
        }
        Book existing = existingOpt.get();
        existing.setTitle(updatedBook.getTitle());
        existing.setIsbn(updatedBook.getIsbn());
        existing.setPrice(updatedBook.getPrice());
        existing.setYearPublished(updatedBook.getYearPublished());
        existing.setAuthor(updatedBook.getAuthor());
        return bookRepository.save(existing);
    }

    /**
     * Execute the custom inner join query between Books and Authors.
     * @return List of BookAuthorDTO containing joined data
     */
    public List<BookAuthorDTO> getBooksWithAuthors() {
        return bookRepository.findAllBooksWithAuthors();
    }
}
