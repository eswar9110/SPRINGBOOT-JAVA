package com.bookauthor.app.service;

import com.bookauthor.app.model.Author;
import com.bookauthor.app.repository.AuthorRepository;
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
 * Unit tests for AuthorService using Mockito.
 */
@ExtendWith(MockitoExtension.class)
public class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;

    @InjectMocks
    private AuthorService authorService;

    private Author sampleAuthor;

    @BeforeEach
    void setUp() {
        sampleAuthor = new Author("Test Author", "test@email.com", "A test bio");
        sampleAuthor.setId(1L);
    }

    @Test
    public void testFindAll() {
        Author author2 = new Author("Author 2", "a2@email.com", "Bio 2");
        author2.setId(2L);
        when(authorRepository.findAll()).thenReturn(Arrays.asList(sampleAuthor, author2));

        List<Author> authors = authorService.findAll();
        assertEquals(2, authors.size());
        verify(authorRepository, times(1)).findAll();
    }

    @Test
    public void testFindById_Found() {
        when(authorRepository.findById(1L)).thenReturn(Optional.of(sampleAuthor));

        Optional<Author> result = authorService.findById(1L);
        assertTrue(result.isPresent());
        assertEquals("Test Author", result.get().getName());
    }

    @Test
    public void testFindById_NotFound() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        Optional<Author> result = authorService.findById(99L);
        assertFalse(result.isPresent());
    }

    @Test
    public void testSave() {
        when(authorRepository.save(any(Author.class))).thenReturn(sampleAuthor);

        Author saved = authorService.save(new Author("Test Author", "test@email.com", "A test bio"));
        assertNotNull(saved);
        assertEquals("Test Author", saved.getName());
        verify(authorRepository, times(1)).save(any(Author.class));
    }

    @Test
    public void testUpdate_Success() {
        when(authorRepository.findById(1L)).thenReturn(Optional.of(sampleAuthor));
        Author updated = new Author("Updated Name", "updated@email.com", "Updated bio");
        when(authorRepository.save(any(Author.class))).thenReturn(sampleAuthor);

        Author result = authorService.update(1L, updated);
        assertNotNull(result);
        verify(authorRepository, times(1)).findById(1L);
        verify(authorRepository, times(1)).save(any(Author.class));
    }

    @Test
    public void testUpdate_NotFound() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> {
            authorService.update(99L, new Author("Name", "e@e.com", "bio"));
        });
    }
}
