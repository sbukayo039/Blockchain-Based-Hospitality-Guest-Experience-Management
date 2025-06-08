;; Feedback Collection Contract
;; Collects and manages guest experience feedback

(define-constant err-not-found (err u400))
(define-constant err-invalid-rating (err u401))
(define-constant err-already-submitted (err u402))

;; Feedback data structure
(define-map feedback-entries
  { guest: principal, hotel-id: uint, booking-id: uint }
  {
    overall-rating: uint,
    service-rating: uint,
    cleanliness-rating: uint,
    amenities-rating: uint,
    comments: (string-ascii 500),
    submitted-block: uint
  }
)

;; Hotel rating aggregates
(define-map hotel-ratings
  { hotel-id: uint }
  {
    total-ratings: uint,
    average-rating: uint,
    total-feedback-count: uint
  }
)

;; Submit feedback
(define-public (submit-feedback
  (hotel-id uint)
  (booking-id uint)
  (overall-rating uint)
  (service-rating uint)
  (cleanliness-rating uint)
  (amenities-rating uint)
  (comments (string-ascii 500))
)
  (begin
    ;; Validate ratings (1-5 scale)
    (asserts! (and (>= overall-rating u1) (<= overall-rating u5)) err-invalid-rating)
    (asserts! (and (>= service-rating u1) (<= service-rating u5)) err-invalid-rating)
    (asserts! (and (>= cleanliness-rating u1) (<= cleanliness-rating u5)) err-invalid-rating)
    (asserts! (and (>= amenities-rating u1) (<= amenities-rating u5)) err-invalid-rating)

    ;; Check if feedback already exists
    (asserts! (is-none (map-get? feedback-entries { guest: tx-sender, hotel-id: hotel-id, booking-id: booking-id })) err-already-submitted)

    ;; Store feedback
    (map-set feedback-entries
      { guest: tx-sender, hotel-id: hotel-id, booking-id: booking-id }
      {
        overall-rating: overall-rating,
        service-rating: service-rating,
        cleanliness-rating: cleanliness-rating,
        amenities-rating: amenities-rating,
        comments: comments,
        submitted-block: block-height
      }
    )

    ;; Update hotel ratings
    (match (map-get? hotel-ratings { hotel-id: hotel-id })
      existing-ratings (let (
        (new-total (+ (get total-ratings existing-ratings) overall-rating))
        (new-count (+ (get total-feedback-count existing-ratings) u1))
        (new-average (/ new-total new-count))
      )
        (map-set hotel-ratings
          { hotel-id: hotel-id }
          {
            total-ratings: new-total,
            average-rating: new-average,
            total-feedback-count: new-count
          }
        )
      )
      (map-set hotel-ratings
        { hotel-id: hotel-id }
        {
          total-ratings: overall-rating,
          average-rating: overall-rating,
          total-feedback-count: u1
        }
      )
    )

    (ok "Feedback submitted")
  )
)

;; Get feedback
(define-read-only (get-feedback (guest principal) (hotel-id uint) (booking-id uint))
  (map-get? feedback-entries { guest: guest, hotel-id: hotel-id, booking-id: booking-id })
)

;; Get hotel ratings
(define-read-only (get-hotel-ratings (hotel-id uint))
  (map-get? hotel-ratings { hotel-id: hotel-id })
)
