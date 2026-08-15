---
Project:
Status:
Priority: P0-Critical
Description:
---

# Connections

| Type         | Route                                        |
| :----------- | :------------------------------------------- |
| **📂 Other** | [area\_2d](../arepitas-de-padres/area_2d.gd) |

# Acceptance Criteria

> [!todo] **Scenario:** arepa initializer
> `Precondition - Action - Outcome`
>
> **Given** the arepa timer can count , **When** the arepa is loaded in the pan , **Then**
>
> 1. The overcooked countdown must start
> 2. The arepa should shake a bit

> [!todo] **Scenario:** Arepa being flip
> `Precondition - Action - Outcome`
>
> **Given** the shake animation is defined , **When** then **pan** is `clicked` , **Then**
> 3\. The counter should be reset
> 4\. The arepa should shake a bit

> [!todo] **Scenario:**
> `Precondition - Action - Outcome`
>
> **Given** the arepa timer can count , **When** the arepa touches the pan , **Then** the overcooked countdown must start

> [!todo] **Scenario:** Arepa Overcooked
> `Precondition - Action - Outcome`
>
> **Given** the arepa burnoutTimer , **When** it hits the limit! , **Then** the game should stop.

*Note:* The easiest approach is that if the arepa is overcooked then you lose the game. If complexity time available we can implement the asset money count decrease.

***

## References

* **Implements:** @trace @
* **Depends On:** @trace SREQ-001C @
* **Parent:** @trace REQ-001 @

***

## PKB References
