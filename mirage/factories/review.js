import { Factory } from 'miragejs';
import { faker } from '@faker-js/faker';
import { addHours } from 'date-fns';

export default Factory.extend({
  reviewer() {
    return `${faker.person.firstName()} ${faker.person.lastName()}`;
  },

  imageUrl() {
    return 'images/review-person3.png';
  },

  text() {
    return faker.lorem.sentence();
  },

  source() {
    return faker.helpers.arrayElement(['Trip Advisor Contributor', 'Yelp Contributor']);
  },

  url() {
    return faker.internet.url();
  },

  createdAt() {
    return faker.date.recent(30);
  },

  updatedAt() {
    return addHours(this.createdAt, 5);
  },
});
