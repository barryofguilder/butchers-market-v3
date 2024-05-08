import { Factory } from 'miragejs';
import { faker } from '@faker-js/faker';

export default Factory.extend({
  title() {
    const wordCount = faker.number.int({ min: 2, max: 5 });
    return faker.lorem.words(wordCount);
  },

  imageUrl() {
    return faker.helpers.arrayElement([
      'images/generic-deli-item-1.jpg',
      'images/generic-deli-item-2.jpg',
      'images/generic-deli-item-3.jpg',
    ]);
  },

  ingredients() {
    const wordCount = faker.number.int({ min: 2, max: 10 });
    return faker.lorem.words(wordCount).replace(' ', ', ');
  },

  isHidden: false,
});
