import {
  Box,
  Button,
  DmIcon,
  Flex,
  Icon,
  NoticeBox,
} from 'tgui-core/components';
import { createSearch } from 'tgui-core/string';

import { useBackend } from '../../../backend';
import { LoadoutCategory, LoadoutItem, LoadoutManagerData } from './base';

export const ItemIcon = (props: { item: LoadoutItem; scale?: number }) => {
  const { item, scale = 3 } = props;
  const icon_to_use = item.icon;
  const icon_state_to_use = item.icon_state;

  if (!icon_to_use || !icon_state_to_use) {
    return (
      <Icon
        name="question"
        size={Math.round(scale * 2.5)}
        color="red"
        style={{
          transform: `translateX(${scale * 2}px) translateY(${scale * 2}px)`,
        }}
      />
    );
  }

  return (
    <DmIcon
      fallback={<Icon name="spinner" spin color="gray" />}
      icon={icon_to_use}
      icon_state={icon_state_to_use}
      style={{
        transform: `scale(${scale}) translateX(${scale * 3}px) translateY(${
          scale * 3
        }px)`,
      }}
    />
  );
};

export const ItemDisplay = (props: {
  active: boolean;
  item: LoadoutItem;
  scale?: number;
}) => {
  const { act } = useBackend();
  const { active, item, scale = 3 } = props;

  const boxSize = `${scale * 32}px`;

  return (
    <Button
      height={boxSize}
      width={boxSize}
      color={active ? 'green' : 'default'}
      style={{ textTransform: 'capitalize', zIndex: '1' }}
      tooltip={item.name}
      tooltipPosition={'bottom'}
      onClick={() =>
        act('select_item', {
          path: item.path,
          deselect: active,
        })
      }
    >
      <Flex vertical>
        <Flex.Item>
          <ItemIcon item={item} scale={scale} />
        </Flex.Item>
        {item.information.length > 0 && (
          <Flex.Item ml={-5.5} style={{ zIndex: '3' }}>
            {item.information.map((info) => (
              <Box
                height="9px"
                key={info}
                fontSize="9px"
                textColor={'darkgray'}
                bold
              >
                {info}
              </Box>
            ))}
          </Flex.Item>
        )}
        {
          // NOVA EDIT START - Expanded loadout framework
          ShouldDisplayRestriction(item) && (
            <Flex.Item ml={5.7} mt={0.35}>
              {ItemRestriction(item)}
            </Flex.Item>
          )
          /* NOVA EDIT END */
        }
      </Flex>
    </Button>
  );
};

const ItemListDisplay = (props: { items: LoadoutItem[] }) => {
  const { data } = useBackend<LoadoutManagerData>();
  const loadout_list =
    data.character_preferences.misc.loadout_lists[
      data.character_preferences.misc.loadout_index
    ]; // BUBBER EDIT: Multiple loadout presets: ORIGINAL: const { loadout_list } = data.character_preferences.misc;
  // NOVA EDIT ADDITION START - Expanded loadout framework
  const itemList = FilterItemList(props.items);
  // NOVA EDIT END
  return (
    <Flex wrap>
      {/* NOVA EDIT - LOADOUT ORIGINAL: {props.items.map((item) => (*/}
      {itemList.map((item) => (
        // NOVA EDIT END
        <Flex.Item key={item.name} mr={2} mb={2}>
          <ItemDisplay
            item={item}
            active={loadout_list && loadout_list[item.path] !== undefined}
          />
        </Flex.Item>
      ))}
    </Flex>
  );
};

// NOVA EDIT ADDITION START - Expanded loadout framework
const FilterItemList = (items: LoadoutItem[]) => {
  const { data } = useBackend<LoadoutManagerData>();
  const { is_donator, is_veteran, erp_pref } = data;
  const ckey = data.ckey;

  return items.filter((item: LoadoutItem) => {
    if (item.ckey_whitelist && item.ckey_whitelist.indexOf(ckey) === -1) {
      return false;
    }
    if (item.donator_only && !is_donator) {
      return false;
    }
    if (item.veteran_only && !is_veteran) {
      return false;
    }
    if (item.erp_item && !erp_pref) {
      return false;
    }

    return true;
  });
};

const ShouldDisplayRestriction = (item: LoadoutItem) => {
  if (
    item.ckey_whitelist ||
    item.restricted_roles ||
    item.blacklisted_roles ||
    item.restricted_species
  ) {
    return true;
  }

  return false;
};

const ItemRestriction = (item: LoadoutItem) => {
  let restrictions: string[] = [];

  if (item.ckey_whitelist) {
    restrictions.push('CKEY Whitelist: ' + item.ckey_whitelist.join(', '));
  }

  if (item.restricted_roles) {
    restrictions.push('Job Whitelist: ' + item.restricted_roles.join(', '));
  }

  if (item.blacklisted_roles) {
    restrictions.push('Job Blacklist: ' + item.blacklisted_roles.join(', '));
  }

  if (item.restricted_species) {
    restrictions.push(
      'Species Whitelist: ' + item.restricted_species.join(', '),
    );
  }

  const tooltip = restrictions.join(', ');

  return (
    <Button
      icon="lock"
      height="22px"
      width="22px"
      color="blue"
      tooltip={tooltip}
      tooltipPosition={'bottom-start'}
      style={{ zIndex: '2' }}
    />
  );
};
// NOVA EDIT END

export const LoadoutTabDisplay = (props: {
  category: LoadoutCategory | undefined;
}) => {
  const { category } = props;
  if (!category) {
    return (
      <NoticeBox>
        Erroneous category detected! This is a bug, please report it.
      </NoticeBox>
    );
  }

  return <ItemListDisplay items={category.contents} />;
};

export const SearchDisplay = (props: {
  loadout_tabs: LoadoutCategory[];
  currentSearch: string;
}) => {
  const { loadout_tabs, currentSearch } = props;
  const { data } = useBackend<LoadoutManagerData>(); // NOVA EDIT ADDITION
  const { erp_pref } = data; // NOVA EDIT ADDITION

  const search = createSearch(
    currentSearch,
    (loadout_item: LoadoutItem) => loadout_item.name,
  );

  const validLoadoutItems = loadout_tabs
    // NOVA EDIT ADDITION START - Prefslocked tabs
    .filter(
      (curTab) => !curTab.erp_category || (curTab.erp_category && erp_pref),
    ) // NOVA EDIT ADDITION END
    .flatMap((tab) => tab.contents)
    .filter(search)
    .sort((a, b) => (a.name > b.name ? 1 : -1));

  if (validLoadoutItems.length === 0) {
    return <NoticeBox>No items found!</NoticeBox>;
  }

  return <ItemListDisplay items={validLoadoutItems} />;
};
