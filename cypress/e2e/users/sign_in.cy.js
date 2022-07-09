/// <reference types="cypress" />

describe('Sign in', () => {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('basic')
    cy.visit('/')
  })

  it('signs in user with valid credentials', () => {
    cy.login('user@example.com', 'user@example.com')
    cy.get('.alert').should('contain', 'Signed in successfully.')
  })

  it('does not sign in user with invalid credentials', () => {
    cy.login('wrong@example.com', 'wrong@example.com')
    cy.url().should('include', '/users/sign_in')
    cy.get('.alert').should('contain', 'Invalid Email or password.')
  })
})
