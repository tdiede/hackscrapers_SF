from unittest import TestCase
from model_buildings import User, Building, Tenant, City, connect_to_db, db, example_data
from server_tmd import app

import os

# Whenever testing drop existing test database and create a new database.
os.system("dropdb testdb")
print "dropdb testdb"
os.system("createdb testdb")
print "createdb testdb"


class FlaskTests(TestCase):
    def setUp(self):
        """Set up sample data before every test."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        connect_to_db(app, 'postgresql:///testdb')

        db.create_all()
        # import pdb; pdb.set_trace()
        example_data()

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    # Confirm all routes are working.
    def test_index(self):
        """Confirm index (login) route successful."""

        result = self.client.get('/')
        self.assertIn('Login', result.data)

    def test_dashboard(self):
        """Confirm dashboard (homepage) route successful."""

        result = self.client.get('/dashboard')
        self.assertIn('Dashboard', result.data)

    def test_register(self):
        """Confirm registration route successful."""

        result = self.client.get('/register')
        self.assertIn('Register', result.data)

    def test_buildings(self):
        """Confirm buildings table route successful."""

        result = self.client.get('/buildings')
        self.assertIn('BUILDINGS', result.data)

    def test_cities(self):
        """Confirm cities table route successful."""

        result = self.client.get('/cities')
        self.assertIn('CITIES', result.data)

    def test_maps(self):
        """Confirm map route successful."""

        result = self.client.get('/map')
        self.assertIn('Map', result.data)

    def test_dendrogram(self):
        """Confirm dendrogram route successful."""

        result = self.client.get('/dendrogram')
        self.assertIn('Dendrogram', result.data)

    # Confirm all queries are working.
    def test_query_user(self):
        """Find user in sample data."""

        me = User.query.filter(User.username == 'me').first()
        self.assertEqual(me.username, 'me')

    def test_query_bldg(self):
        """Find bldg in sample data."""

        bldg = Building.query.filter(Building.bldg_id == 1).first()
        self.assertEqual(bldg.place_id, 'ChIJWdUJpGOAhYARfBVi2TE8daI')

    def test_query_tenant(self):
        """Find tenant in sample data."""

        tenant = Tenant.query.filter(Tenant.tenant_id == 1).first()
        self.assertEqual(tenant.tenant, '50 Fremont Center')

    def test_query_city(self):
        """Find city in sample data."""

        city = City.query.filter(City.city_id == 41).first()
        self.assertEqual(city.rank, 40)


class MockRouteTests(TestCase):
    """Flask tests that show off mocking."""

    def setUp(self):
        """Set up test database and mock api result."""

        self.client = app.test_client()
        app.config['TESTING'] = True
        connect_to_db(app, "postgresql:///testdb")

        db.create_all()
        example_data()

        # Make mock.
        # def mock_function(input):

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()


if __name__ == "__main__":
    import unittest

    unittest.main()
