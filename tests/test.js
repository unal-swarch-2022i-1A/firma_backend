const request = require('supertest')('http://localhost:8091');

describe('Users API', () => {
    it('GET /docs/1', () => {
        // Make a GET request to the users route 
        return request.get('/users').expect(200);
    });
});