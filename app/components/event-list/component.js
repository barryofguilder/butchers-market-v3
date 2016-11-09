import Ember from 'ember';
import moment from 'moment';
import momentSort from '../../utils/moment-sort';

export default Ember.Component.extend({
  events: null,
  sortedEvents: Ember.computed.sort('events', momentSort),
  eventsByMonth: Ember.computed('sortedEvents.@each', function() {
    let events = this.get('sortedEvents');
    let now = moment();

    let upcomingEvents = events.filter(event => {
      let date = event.get('momentStartTime');
      return date.isSameOrAfter(now, 'day');
    });

    let eventsLength = upcomingEvents.get('length');
    let eventsByMonth = Ember.A();
    let monthEvents = Ember.A();

    for (let i = 0; i < eventsLength; i++) {
      let date = upcomingEvents[i].get('momentStartTime');
      let month = date.month();

      if (monthEvents.get('length')) {
        let recentDate = monthEvents[0].get('momentStartTime');

        if (month !== recentDate.month()) {
          eventsByMonth.pushObject(monthEvents);
          monthEvents = Ember.A();
        }
      }

      monthEvents.pushObject(upcomingEvents[i]);
    }

    if (monthEvents.get('length') > 0) {
      eventsByMonth.pushObject(monthEvents);
    }

    return eventsByMonth;
  }),
  eventColumns: Ember.computed('media.isMobile', function() {
    return this.get('media.isMobile') ? 2 : 3;
  })
});
