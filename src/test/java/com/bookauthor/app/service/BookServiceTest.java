package com.bookauthor.app.service;

import com.bookauthor.app.dto.BookAuthorDTO;
import com.bookauthor.app.model.Author;
import com.bookauthor.app.model.Book;
import com.bookauthor.app.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for BookService using Mockito.
 */
@ExtendWith(MockitoExtension.class)
public class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookService bookService;

    private Book sampleBook;
    private Author sampleAuthor;

    @BeforeEach
    void setUp() {
        sampleAuthor = new Author("Test Author", "test@email.com", "Bio");
        sampleAuthor.setId(1L);
        sampleBook = new Book("Test Book", "978-0-0000-0000-0", 29.99, 2024, sampleAuthor);
        sampleBook.setId(1L);
    }

    @Test
    public void testFindAll() {
        when(bookRepository.findAll()).thenReturn(Arrays.asList(sampleBook));

        List<Book> books = bookService.findAll();
        assertEquals(1, books.size());
        assertEquals("Test Book", books.get(0).getTitle());
        verify(bookRepository, times(1)).findAll();
    }

    @Test
    public void testFindById_Found() {
        when(bookRepository.findById(1L)).thenReturn(Optional.of(sampleBook));

        Optional<Book> result = bookService.findById(1L);
        assertTrue(result.isPresent());
        assertEquals("Test Book", result.get().getTitle());
    }

    @Test
    public void testFindById_NotFound() {
        when(bookRepository.findById(99L)).thenReturn(Optional.empty());

        Optional<Book> result = bookService.findById(99L);
        assertFalse(result.isPresent());
    }

    @Test
    public void testSave() {
        when(bookRepository.save(any(Book.class))).thenReturn(sampleBook);

        Book saved = bookService.save(sampleBook);
        assertNotNull(saved);
        assertEquals("Test Book", saved.getTitle());
        verify(bookRepository, times(1)).save(any(Book.class));
    }

    @Test
    public void testUpdate_Success() {
        when(bookRepository.findById(1L)).thenReturn(Optional.of(sampleBook));
        when(bookRepository.save(any(Book.class))).thenReturn(sampleBook);

        Book updated = new Book("Updated", "978-1-1111-1111-1", 39.99, 2025, sampleAuthor);
        Book result = bookService.update(1L, updated);

        assertNotNull(result);
        verify(bookRepository, times(1)).findById(1L);
        verify(bookRepository, times(1)).save(any(Book.class));
    }

    @Test
    public void testUpdate_NotFound() {
        when(bookRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> {
            bookService.update(99L, sampleBook);
        });
    }

    @Test
    public void testGetBooksWithAuthors() {
        BookAuthorDTO dto1 = new BookAuthorDTO("Book1", "isbn1", 10.0, 2020, "Author1", "a1@e.com");
        BookAuthorDTO dto2 = new BookAuthorDTO("Book2", "isbn2", 20.0, 2021, "Author2", "a2@e.com");
        when(bookRepository.findAllBooksWithAuthors()).thenReturn(Arrays.asList(dto1, dto2));

        List<BookAuthorDTO> results = bookService.getBooksWithAuthors();
        assertEquals(2, results.size());
        assertEquals("Book1", results.get(0).getBookTitle());
        assertEquals("Author2", results.get(1).getAuthorName());
        verify(bookRepository, times(1)).findAllBooksWithAuthors();
    }
}
