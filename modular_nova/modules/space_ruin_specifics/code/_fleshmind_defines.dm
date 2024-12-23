// GENERAL DEFINES

/// A list of objects that are considered part of a door, used to determine if a wireweed should attack it.
#define DOOR_OBJECT_LIST list(\
	/obj/machinery/door/airlock, \
	/obj/structure/door_assembly, \
	/obj/machinery/door/firedoor, \
	/obj/machinery/door/window, \
	)
// Faction the building and mobs belong to
#define FACTION_FLESHMIND "fleshmind"

#define MALFUNCTION_RESET_TIME 3 SECONDS

#define MALFUNCTION_CORE_DEATH_RESET_TIME 20 SECONDS

#define STRUCTURE_EMP_LIGHT_DISABLE_TIME 3 SECONDS

#define STRUCTURE_EMP_HEAVY_DISABLE_TIME 7 SECONDS

#define STRUCTURE_EMP_LIGHT_DAMAGE 30

#define STRUCTURE_EMP_HEAVY_DAMAGE 50

#define MOB_EMP_LIGHT_DAMAGE 5

#define MOB_EMP_HEAVY_DAMAGE 10

#define FLESHMIND_NAME_MODIFIER_LIST list ("Warped", "Altered", "Modified", "Upgraded", "Abnormal", "Twisted")

/// The range at which most of our objects, mobs and structures activate at. 7 seems to be the perfect number.
#define DEFAULT_VIEW_RANGE 7

#define MALFUNCTION_CHANCE_LOW 0.5
#define MALFUNCTION_CHANCE_MEDIUM 1
#define MALFUNCTION_CHANCE_HIGH 2

#define SPECIES_MONKEY_MAULER "monkey_mauler"

#define FLESHMIND_LIGHT_BLUE "#00FFCC"

/// Core is in danger, engage turboboosters
#define MOB_RALLY_SPEED 1

/// The max spread distance a wireweed can spread thru a vent.
#define MAX_VENT_SPREAD_DISTANCE 6

#define FLESHMIND_EVENT_MAKE_CORRUPTION_CHANCE 2

#define FLESHMIND_EVENT_MAKE_CORRUPT_MOB 1

// CONTROLLER RELATED DEFINES

#define AI_SURNAME_LIST list( \
	"Mk I", \
	"Mk II", \
	"Mk III", \
	"Mk IV", \
	"Mk V", \
	"Mk VI", \
	"Mk VII", \
	"Mk VIII", \
	"Mk IX", \
	"Mk X", \
	"Mk XI", \
	"Mk XII", \
	"Mk XIII", \
	"Mk XIV", \
	"v0.9", \
	"v1.0", \
	"v1.1", \
	"v2.0", \
	"2418-B", \
	"Activated Shard", \
	"Pre-Release", \
	"Commercial Release", \
	"Closed Alpha", \
	"Hivebuilt", \
)

/// The controller must reach this before it can level up to the next level.
#define CONTROLLER_LEVEL_1 1

// Balance specific defines

// How much progress is required to spread?
#define FLESHCORE_SPREAD_PROGRESS_REQUIRED 200
// How many times do we need to spread until we can create a new structure?
#define FLESHCORE_SPREADS_FOR_STRUCTURE 50
// Upon creation, how many times do we spread instantly?
#define FLESHCORE_INITIAL_EXPANSION_SPREADS 30
// Upon creation, how many structures do we spawn instantly?
#define FLESHCORE_INITIAL_EXPANSION_STRUCTURES 5
// Every subsystem fire, how much progress do we gain?
#define FLESHCORE_SPREAD_PROGRESS_PER_SUBSYSTEM_FIRE 40
// The baseline of the above.
#define FLESHCORE_BASE_SPREAD_PROGRESS_PER_SUBSYSTEM_FIRE 40
// How likely are we to attack every SS fire?
#define FLESHCORE_ATTACK_PROB 20
// How likely are we to spawn a wall to seal a gap every SS fire?
#define FLESHCORE_WALL_PROB 30
// The amount of time until we can activate nearby wireweed again.
#define FLESHCORE_NEXT_CORE_DAMAGE_WIREWEED_ACTIVATION_COOLDOWN 10 SECONDS

#define CONTROLLER_DEATH_DO_NOTHING 1
#define CONTROLLER_DEATH_SLOW_DECAY 2
#define CONTROLLER_DEATH_DELETE_ALL 3

// WIREWEED RELATED DEFINES

// If damage happens within range, build a wall between the source and the core
#define CORE_DAMAGE_WIREWEED_ACTIVATION_RANGE 6
// Range allowed to build a wall around the core based on proximity
#define GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE 2
// Time it takes to cut wireweed
#define WIREWEED_WIRECUTTER_KILL_TIME 0.5 SECONDS
// Chance if Wireweed heals you while standing on it
#define WIREWEED_HEAL_CHANCE 10
// Amount healed if heal chance is proc'd
#define WIREWEED_HEAL_AMOUNT 6
