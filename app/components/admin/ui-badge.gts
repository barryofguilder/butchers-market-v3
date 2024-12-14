import Component from '@glimmer/component';

export type UiBadgeColor = 'blue' | 'gray' | 'green' | 'purple' | 'red' | 'yellow';
export type UiBadgeSize = 'default' | 'small';

export interface UiBadgeSignature {
  Element: HTMLSpanElement;
  Args: {
    size?: UiBadgeSize;
    color?: UiBadgeColor;
  };
  Blocks: {
    default: [];
  };
}

const colorDefaultClasses: Record<UiBadgeColor, string> = {
  blue: 'bg-blue-50 text-blue-700 ring-blue-600/10',
  gray: 'bg-gray-50 text-gray-600 ring-gray-500/10',
  green: 'bg-green-50 text-green-700 ring-green-600/10',
  purple: 'bg-purple-50 text-purple-700 ring-purple-600/10',
  red: 'bg-red-50 text-red-700 ring-red-600/10',
  yellow: 'bg-yellow-50 text-yellow-700 ring-yellow-600/10',
};
const sizeClasses: Record<UiBadgeSize, string> = {
  default: 'px-2 py-1 text-xs',
  small: 'px-2 py-px text-xs',
};

export default class UiBadgeComponent extends Component<UiBadgeSignature> {
  get color() {
    return this.args.color ?? 'gray';
  }

  get colorClasses() {
    return colorDefaultClasses[this.color];
  }

  get size() {
    return this.args.size ?? 'default';
  }

  get sizeClasses() {
    return sizeClasses[this.size];
  }

  <template>
    <span
      data-test-id='badge'
      class='inline-flex items-center gap-x-1.5 whitespace-nowrap rounded-md font-medium ring-1 ring-inset
        {{this.colorClasses}}
        {{this.sizeClasses}}'
      ...attributes
    >
      {{yield}}
    </span>
  </template>
}
