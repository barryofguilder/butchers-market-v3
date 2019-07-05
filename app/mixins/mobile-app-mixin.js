import { bool } from '@ember/object/computed';
import { inject as service } from '@ember/service';
import Mixin from '@ember/object/mixin';

export default Mixin.create({
  mobileApp: service(),

  isMobileApp: bool('mobileApp.isMobileApp'),

  beforeModel(params) {
    let isMobileApp = params.to.queryParams.mobile ? true : false;

    this.set('mobileApp.isMobileApp', isMobileApp);

    if (isMobileApp) {
      let classNames = this.get('classNames');
      classNames.push('mobile-app');
    }
  },
});
