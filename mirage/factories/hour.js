import { Factory } from 'ember-cli-mirage';
import faker from 'faker';
import addWeeks from 'date-fns/addWeeks';

export default Factory.extend({
  type() {
    return faker.random.arrayElement(['Cafe', 'Store']);
  },

  default() {
    return false;
  },

  activeStartDate() {
    if (this.default === false) {
      return faker.date.past(2);
    }
  },

  activeEndDate() {
    if (this.default === false) {
      return addWeeks(this.activeStartDate, 2);
    }
  },

  label() {
    const wordCount = faker.random.number({ min: 1, max: 6 });
    return faker.lorem.words(wordCount);
  },

  line1() {
    return 'Mon - Thurs: 9:00am - 5:30pm';
  },

  line2() {
    return 'Fri & Sat: 9:00am - 10:00pm';
  },
});
