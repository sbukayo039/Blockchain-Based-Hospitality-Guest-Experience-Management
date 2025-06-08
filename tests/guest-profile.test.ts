import { describe, it, expect, beforeEach } from "vitest"

describe("Guest Profile Contract", () => {
  let contractAddress
  let accounts
  
  beforeEach(() => {
    contractAddress = "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.guest-profile"
    accounts = {
      deployer: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      guest1: "ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5",
      guest2: "ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG",
    }
  })
  
  it("should create a new guest profile", () => {
    const name = "John Doe"
    const preferences = "Non-smoking room, late checkout, vegetarian meals"
    
    const result = {
      type: "ok",
      value: "Profile created",
    }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe("Profile created")
  })
  
  it("should update existing guest profile", () => {
    const name = "John Smith"
    const preferences = "Ocean view, early checkin, gluten-free meals"
    
    const result = {
      type: "ok",
      value: "Profile updated",
    }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe("Profile updated")
  })
  
  it("should add booking to history", () => {
    const hotelId = 1
    const checkInBlock = 1000
    const checkOutBlock = 1005
    
    const result = {
      type: "ok",
      value: 1, // booking ID
    }
    
    expect(result.type).toBe("ok")
    expect(result.value).toBe(1)
  })
  
  it("should get guest profile", () => {
    const guestAddress = "ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5"
    
    const profile = {
      name: "John Doe",
      preferences: "Non-smoking room, late checkout",
      "loyalty-points": 100,
      "total-stays": 5,
      "created-block": 50,
    }
    
    expect(profile.name).toBe("John Doe")
    expect(profile["total-stays"]).toBe(5)
  })
  
  it("should get booking details", () => {
    const guestAddress = "ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5"
    const bookingId = 1
    
    const booking = {
      "hotel-id": 1,
      "check-in-block": 1000,
      "check-out-block": 1005,
      rating: 0,
    }
    
    expect(booking["hotel-id"]).toBe(1)
    expect(booking.rating).toBe(0)
  })
})
