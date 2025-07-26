;; Token Rewarded YouTube-style Platform
;; Educators earn STX for views

(define-map educator-rewards principal uint)

(define-constant err-invalid-view-count (err u100))
(define-constant err-invalid-payment (err u101))

;; Function 1: Reward an educator with STX based on view count
(define-public (reward-educator (educator principal) (views uint) (rate uint))
  (begin
    (asserts! (> views u0) err-invalid-view-count)
    (let ((amount (* views rate)))
      (try! (stx-transfer? amount tx-sender educator))
      (map-set educator-rewards educator
               (+ (default-to u0 (map-get? educator-rewards educator)) amount))
      (ok amount)
    )
  )
)
;; Function 2: Read total STX earned by an educator
(define-read-only (get-educator-rewards (educator principal))
  (ok (default-to u0 (map-get? educator-rewards educator)))
)
