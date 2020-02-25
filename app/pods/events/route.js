import Route from '@ember/routing/route';
import { action } from '@ember/object';
import RSVP from 'rsvp';

export default class EventsRoute extends Route {
  model() {
    return RSVP.hash({
      events: this.store.findAll('event'),
      hours: this.store.findAll('hour'),
      performances: this.store.findAll('performance'),
      reviews: this.store.findAll('review'),
    });
  }

  @action
  willTransition(/*transition*/) {
    // Makes sure that the page gets scrolled to the top when changing routes.
    window.scrollTo(0, 0);
  }
}
