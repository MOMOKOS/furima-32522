const pay = () => {
  Payjp.setPublicKey("pk_test_88fe4509bd6319c14dcfe81a"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_destination[card-number]"),
      cvc: formData.get("order_destination[card-cvc]"),
      exp_month: formData.get("order_destination[card-exp-month]"),
      exp_year: `20${formData.get("order_destination[card-exp-year]")}`,
    };
    console.log(card)

    Payjp.createToken(card, (status, response) => {
      console.log(response)
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        debugger;
      }
    });
  });
};

window.addEventListener("load", pay);