import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import type { TOC } from '@ember/component/template-only';
import type { EmptyObject } from '@ember/component/helper';
import type { WithBoundArgs } from '@glint/template';
import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import type { RouteModel } from '@ember/routing/router-service';
import UiBaseLink from '../ui-base-link';
import UiIcon from '../ui-icon';

interface UiListItemSignature {
  Element: HTMLLIElement;
  Args: {
    href?: string;
    model?: RouteModel;
    models?: [RouteModel];
    query?: Record<string, unknown>;
    route?: string;
  };
  Blocks: {
    default: [];
    content: [];
  };
}

class UiListItem extends Component<UiListItemSignature> {
  @tracked expanded = false;

  get isLink() {
    return this.args.href || this.args.route;
  }

  @action
  toggleExpanded() {
    this.expanded = !this.expanded;
  }

  <template>
    <li class='relative' ...attributes>
      {{#if this.isLink}}
        <UiBaseLink
          @href={{@href}}
          @route={{@route}}
          @model={{@model}}
          @models={{@models}}
          @query={{@query}}
          class='py-5 px-4 flex justify-between items-center gap-x-6 hover:bg-gray-50'
        >
          <span>{{yield}}</span>
          <UiIcon @icon='chevron-right' class='text-gray-400' />
        </UiBaseLink>
      {{else}}
        {{#if (has-block 'content')}}
          <button
            type='button'
            class='py-5 px-4 w-full flex justify-between items-center gap-x-6 text-left hover:bg-gray-50'
            {{on 'click' this.toggleExpanded}}
          >
            <span>{{yield}}</span>
            <span class='transition text-gray-400 {{if this.expanded "-rotate-180"}}'>
              <UiIcon @icon='chevron-down' />
            </span>
          </button>

          {{#if this.expanded}}
            <div class='mt-1'>
              {{yield to='content'}}
            </div>
          {{/if}}
        {{else}}
          <div class='py-5 px-4'>
            {{yield}}
          </div>
        {{/if}}
      {{/if}}
    </li>
  </template>
}

export interface UiListSignature {
  Element: HTMLUListElement;
  Args: EmptyObject;
  Blocks: {
    default: [
      {
        Item: WithBoundArgs<typeof UiListItem, never>;
      },
    ];
  };
}

const UiListComponent: TOC<UiListSignature> = <template>
  <ul
    role='list'
    class='border border-gray-200 divide-y divide-gray-200 rounded-md overflow-hidden'
    ...attributes
  >
    {{yield (hash Item=(component UiListItem))}}
  </ul>
</template>;

export default UiListComponent;

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    'Admin::UiList': typeof UiListComponent;
  }
}
