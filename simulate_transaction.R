simulate_transaction <- function() {
  # Seller inputs reserved price (RP) and ideal price (IP)
  RP <- as.numeric(readline("Enter the reserved price (RP): "))
  price_range <- c(RP, 2 * RP)
  cat("Your price range is: ", price_range[1], "to", price_range[2], "\n")
  IP <- as.numeric(readline("Enter the ideal price (IP), which should be less than the upper limit: "))
  
  buyers <- 5
  bids <- numeric(buyers)
  
  for (i in 1:buyers) {
    UP <- as.numeric(readline(sprintf("Buyer %d, enter your price upper limit (UP): ", i)))
    if (RP > UP) {
      cat("Transaction canceled.\n")
      next
    }
    
    BID1 <- runif(1, min=RP, max=2 * RP)
    cat(sprintf("Buyer %d's randomly generated first bid is: %f\n", i, BID1))
    Prob1 <- (BID1 - RP) / (IP - RP)
    print(Prob1)
    
    BID2 <- runif(1, min=RP, max=max(BID1, IP))
    cat(sprintf("Buyer %d's randomly generated second bid is: %f\n", i, BID2))
    Prob2 <- (BID2 - RP) / (IP - RP)
    print(Prob2)
    
    final_bid <- ifelse(BID1 < BID2, (BID1 + 1.5 * RP) / 2, (RP + BID1) / 2)
    bids[i] <- final_bid
  }
  
  MAX <- max(bids)
  
  if (MAX > IP) {
    cat("Transaction successfully matched.\n")
  } else {
    cat("Transaction not matched. Would you like to accept the highest bid?\n")
    decision <- readline("Enter 'accept' to accept the highest bid, or anything else to cancel: ")
    if (decision == "accept") {
      cat("Transaction successfully matched.\n")
    } else {
      cat("Transaction canceled.\n")
    }
  }
}
