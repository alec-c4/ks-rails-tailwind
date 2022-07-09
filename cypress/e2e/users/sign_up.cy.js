/// <reference types="cypress" />

describe('Sign up', () => {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('sign_up')
    cy.visit('/')
  })

  it('does not sign up user without any data', () => {
    cy.register(null, null, null, null)
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Email can\'t be blank\n')
    cy.get('.alert').should('contain', 'Password can\'t be blank\n')
    cy.get('.alert').should('contain', 'Name must contain both first and last name')
  })

  it('does not sign up user without name', () => {
    cy.register(null, 'wrong@example.com', 'wrong@example.com', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Name must contain both first and last name')
  })

  it('does not sign up user with invalid name', () => {
    cy.register('Full', 'wrong@example.com', 'wrong@example.com', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Name must contain both first and last name')
  })

  it('does not sign up user without email', () => {
    cy.register('Full Name', null, 'wrong@example.com', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Email can\'t be blank\n')
  })

  it('does not sign up user with invalid email', () => {
    cy.register('Full Name', 'wrong', 'wrong@example.com', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Email is invalid')
  })

  it('does not sign up user without password', () => {
    cy.register('Full Name', 'wrong@example.com', null, 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Password can\'t be blank\n')
    cy.get('.alert').should('contain', 'Password confirmation doesn\'t match Password')
  })

  it('does not sign up user with invalid password', () => {
    cy.register('Full Name', 'wrong@example.com', '1', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Password confirmation doesn\'t match Password')
    cy.get('.alert').should('contain', 'Password is too short (minimum is 6 characters)')
    cy.get('.alert').should('contain', 'Password has previously appeared in a data breach and should never be used. Please choose something harder to guess.')
  })

  it('does not sign up user with different password and password confirmation', () => {
    cy.register('Full Name', 'wrong@example.com', 'test@ecample.com', 'wrong@example.com')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Password confirmation doesn\'t match Password')
  })

  it('does not sign up user without password confirmation', () => {
    cy.register('Full Name', 'wrong@example.com', 'wrong@example.com', null)
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Password confirmation doesn\'t match Password')
  })

  it('does not sign up user with invalid password confirmation', () => {
    cy.register('Full Name', 'wrong@example.com', 'wrong@example.com', '1')
    cy.url().should('include', '/users')
    cy.get('.alert').should('contain', 'Password confirmation doesn\'t match Password')
  })

  it('does  sign up user with valid data', () => {
    cy.register('Full Name', 'email@example.com', 'email@example.com', 'email@example.com')
    cy.get('.alert').should('contain', 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')

  })
})
