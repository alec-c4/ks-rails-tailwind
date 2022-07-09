// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.add('login', (email, password) => {
  cy.get('#sign_in_link').click()
  cy.url().should('include', '/users/sign_in')

  if (email) {
    cy.get('#user_email').type(email)
  }

  if (password) {
    cy.get('#user_password').type(password)
  }

  cy.get('.form-actions > .btn')
    .contains('Log in')
    .click()
})

Cypress.Commands.add('register', (full_name, email, password, password_confirmation) => {
  cy.get('#sign_up_link').click()
  cy.url().should('include', '/users/sign_up')

  if (full_name) {
    cy.get('#user_name').type(full_name)
  }

  if (email) {
    cy.get('#user_email').type(email)
  }

  if (password) {
    cy.get('#user_password').type(password)
  }

  if (password_confirmation) {
    cy.get('#user_password_confirmation').type(password_confirmation)
  }

  cy.get('.form-actions > .btn')
    .contains('Sign up')
    .click()
})