package com.bookauthor.app.repository;

import com.bookauthor.app.dto.BookAuthorDTO;
import com.bookauthor.app.model.Author;
import com.bookauthor.app.model.Book;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for BookRepository.
 * Tests CRUD operations and the custom inner join query.
 */
@DataJpaTest
public class BookRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private BookRepository bookRepository;

    private Author createTestAuthor(String name, String email) {
        Author author = new Author(name, email, "Test bio");
        return entityManager.persist(author);
    }

    @Test
    public void testSaveBook() {
        Author author = createTestAuthor("Save Author", "save@email.com");
        entityManager.flush();

        Book book = new Book("Test Book", "978-1-1111-1111-1", 19.99, 2024, author);
        Book saved = bookRepository.save(book);

        assertNotNull(saved.getId());
        assertEquals("Test Book", saved.getTitle());
        assertEquals("978-1-1111-1111-1", saved.getIsbn());
    }

    @Test
    public void testFindAllBooks() {
        Author author = createTestAuthor("All Author", "all@email.com");
        entityManager.persist(new Book("Book A", "978-1-0000-0001-1", 10.0, 2020, author));
        entityManager.persist(new Book("Book B", "978-1-0000-0002-1", 15.0, 2021, author));
        entityManager.flush();

        List<Book> books = bookRepository.findAll();
        assertTrue(books.size() >= 2);
    }

    @Test
    public void testFindById() {
        Author author = createTestAuthor("Find Author", "find@email.com");
        Book book = new Book("Find Book", "978-1-2222-2222-1", 25.0, 2023, author);
        Book persisted = entityManager.persist(book);
        entityManager.flush();

        Optional<Book> found = bookRepository.findById(persisted.getId());
        assertTrue(found.isPresent());
        assertEquals("Find Book", found.get().getTitle());
    }

    @Test
    public void testFindByIsbn() {
        Author author = createTestAuthor("ISBN Author", "isbn@email.com");
        entityManager.persist(new Book("ISBN Book", "978-1-3333-3333-1", 30.0, 2022, author));
        entityManager.flush();

        Book found = bookRepository.findByIsbn("978-1-3333-3333-1");
        assertNotNull(found);
        assertEquals("ISBN Book", found.getTitle());
    }

    @Test
    public void testUpdateBook() {
        Author author = createTestAuthor("Update Author", "upd@email.com");
        Book book = new Book("Old Title", "978-1-4444-4444-1", 20.0, 2020, author);
        Book persisted = entityManager.persist(book);
        entityManager.flush();

        persisted.setTitle("New Title");
        persisted.setPrice(35.0);
        Book updated = bookRepository.save(persisted);

        assertEquals("New Title", updated.getTitle());
        assertEquals(35.0, updated.getPrice());
    }

    @Test
    public void testFindAllBooksWithAuthors_InnerJoin() {
        Author author1 = createTestAuthor("Join Author1", "join1@email.com");
        Author author2 = createTestAuthor("Join Author2", "join2@email.com");
        entityManager.persist(new Book("Join Book1", "978-1-5555-5555-1", 12.0, 2019, author1));
        entityManager.persist(new Book("Join Book2", "978-1-6666-6666-1", 18.0, 2020, author2));
        entityManager.flush();

        List<BookAuthorDTO> results = bookRepository.findAllBooksWithAuthors();
        assertTrue(results.size() >= 2);

        BookAuthorDTO first = results.stream()
            .filter(dto -> dto.getBookTitle().equals("Join Book1"))
            .findFirst().orElse(null);
        assertNotNull(first);
        assertEquals("Join Author1", first.getAuthorName());
        assertEquals("join1@email.com", first.getAuthorEmail());
    }
}
