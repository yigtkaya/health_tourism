const functions = require('firebase-functions');
const Iyzipay = require('iyzipay');

var iyzipay = new Iyzipay({
  apiKey: functions.config().iyzico.apikey,
  secretKey: functions.config().iyzico.secretkey,
  uri: functions.config().iyzico.link
});

// Ödeme işlemi için bir HTTP isteği dinleyen Firebase Function
exports.makePayment = functions.https.onRequest(async (req, res) => {
  try {
    // İstekten gelen verileri alın
    const {package, buyer, price, cardHolderName, cardNumber, expireMonth, expireYear, cvc } = req.body;

    var request = {
        locale: Iyzipay.LOCALE.EN,
        price: price,
        paidPrice: price,
        currency: Iyzipay.CURRENCY.USD,
        installment: "1",
        paymentCard: {
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            expireMonth: expireMonth,
            expireYear: expireYear,
            cvc: cvc,
            registerCard: "0"
        },
        buyer: {
            id: buyer.id,
            name: buyer.name,
            surname: buyer.sirName,
            email: buyer.email,
            identityNumber: '74300864791', // is it going to be fix number?
            registrationAddress: buyer.address,
            ip: buyer.ip,
            city: buyer.city,
            country: buyer.country,

        },
        address: {
            'contactName': buyer.fullName,
            'city': buyer.city,
            'country': buyer.country,
            'address': buyer.address,
        },
        basketItems: [
            {
                id: package.id,
                name: package.packageName,
                category1: package.category,
                itemType: Iyzipay.BASKET_ITEM_TYPE.VIRTUAL,
                price: package.price,
            },
        ]
    }

    // Ödeme işlemini yapmak için gerekli kodları buraya ekleyin
    // Ödeme işlemi başarılı veya başarısız olduğuna göre status değeri ve diğer bilgileri ayarlayın

    // Ödeme işlemi başarılı ise
    const response = {
      status: "success",
      paymentStatus: null,
      // Diğer dönüş parametreleri...
    };

    // Ödeme işlemi başarısız ise
    // const response = {
    //   status: "failure",
    //   errorCode: "HATA_KODU",
    //   errorMessage: "HATA_MESAJI",
    //   errorGroup: "HATA_GRUBU",
    //   // Diğer dönüş parametreleri...
    // };

    res.status(200).json(response);
  } catch (error) {
    console.error("Ödeme işlemi hatasi:", error);
    res.status(500).send("Ödeme işlemi sirasinda bir hata oluştu.");
  }
});
