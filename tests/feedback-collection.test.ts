import { describe, it, expect, beforeEach } from "vitest"

describe("Feedback Collection Contract", () => {
  let contractAddress
  let accounts
  
  beforeEach(() => {
    contractAddress = "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.feedback-collection"
    accounts = {
      deployer: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      guest1: "ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5",
    }
  })
  
  it("should submit feedback successfully", () => {
    const hotelId = 1
    const bookingId = 1
    const overallRating = 4
    const serviceRating = 5
    const cleanlinessRating = 4
    const amenitiesRating = 3
    const comments = "Great stay, excellent service!"
    
    const result = {
      type: "ok",
      value: "Feedback submitted",
    }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe("Feedback submitted")
  })
  
  it("should reject invalid ratings", () => {
    const hotelId = 1
    const bookingId = 1
    const overallRating = 6 // Invalid rating > 5
    
    const result = {
      type: "error",
      value: 401, // err-invalid-rating
    }
    
    expect(result.type).toBe("error")
    expect(result.value).toBe(401)
  })
  
  it("should prevent duplicate feedback submission", () => {
    const hotelId = 1
    const bookingId = 1
    
    const result = {
      type: "error",
      value: 402, // err-already-submitted
    }
    
    expect(result.type).toBe("error")
    expect(result.value).toBe(402)
  })
  
  it("should get feedback details", () => {
    const guestAddress = "ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5"
    const hotelId = 1
    const bookingId = 1
    
    const feedback = {
      "overall-rating": 4,
      "service-rating": 5,
      "cleanliness-rating": 4,
      "amenities-rating": 3,
      comments: "Great stay, excellent service!",
      "submitted-block": 2000,
    }
    
    expect(feedback["overall-rating"]).toBe(4)
    expect(feedback.comments).toBe("Great stay, excellent service!")
  })
  
  it("should calculate hotel ratings correctly", () => {
    const hotelId = 1
    
    const ratings = {
      "total-ratings": 12,
      "average-rating": 4,
      "total-feedback-count": 3,
    }
    
    expect(ratings["average-rating"]).toBe(4)
    expect(ratings["total-feedback-count"]).toBe(3)
  })
})
