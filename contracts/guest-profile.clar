;; Guest Profile Contract
;; Manages guest preferences and booking history

(define-constant err-not-found (err u200))
(define-constant err-unauthorized (err u201))

;; Guest profile data structure
(define-map guest-profiles
  { guest: principal }
  {
    name: (string-ascii 100),
    preferences: (string-ascii 500),
    loyalty-points: uint,
    total-stays: uint,
    created-block: uint
  }
)

;; Booking history
(define-map booking-history
  { guest: principal, booking-id: uint }
  {
    hotel-id: uint,
    check-in-block: uint,
    check-out-block: uint,
    rating: uint
  }
)

(define-data-var next-booking-id uint u1)

;; Create or update guest profile
(define-public (update-profile (name (string-ascii 100)) (preferences (string-ascii 500)))
  (let ((existing-profile (map-get? guest-profiles { guest: tx-sender })))
    (match existing-profile
      profile-data (begin
        (map-set guest-profiles
          { guest: tx-sender }
          (merge profile-data { name: name, preferences: preferences })
        )
        (ok "Profile updated")
      )
      (begin
        (map-set guest-profiles
          { guest: tx-sender }
          {
            name: name,
            preferences: preferences,
            loyalty-points: u0,
            total-stays: u0,
            created-block: block-height
          }
        )
        (ok "Profile created")
      )
    )
  )
)

;; Add booking to history
(define-public (add-booking (hotel-id uint) (check-in-block uint) (check-out-block uint))
  (let ((booking-id (var-get next-booking-id)))
    (map-set booking-history
      { guest: tx-sender, booking-id: booking-id }
      {
        hotel-id: hotel-id,
        check-in-block: check-in-block,
        check-out-block: check-out-block,
        rating: u0
      }
    )
    (var-set next-booking-id (+ booking-id u1))
    ;; Update total stays
    (match (map-get? guest-profiles { guest: tx-sender })
      profile-data (begin
        (map-set guest-profiles
          { guest: tx-sender }
          (merge profile-data { total-stays: (+ (get total-stays profile-data) u1) })
        )
        (ok booking-id)
      )
      err-not-found
    )
  )
)

;; Get guest profile
(define-read-only (get-profile (guest principal))
  (map-get? guest-profiles { guest: guest })
)

;; Get booking details
(define-read-only (get-booking (guest principal) (booking-id uint))
  (map-get? booking-history { guest: guest, booking-id: booking-id })
)
