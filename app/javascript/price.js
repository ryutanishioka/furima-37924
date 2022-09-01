function price(){
  const priceInput = document.getElementById("item-price")
  const addTaxPrice = document.getElementById("add-tax-price")
  const proFit = document.getElementById("profit")

  priceInput.addEventListener("keyup", () => {
    const value = priceInput.value
    const tax = Math.trunc(value / 10)
    addTaxPrice.innerHTML = tax

    const profit = value - tax
    proFit.innerHTML = profit

  })
 }
window.addEventListener('load', price)