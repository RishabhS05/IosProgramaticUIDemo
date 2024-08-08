//
//  ARC.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

/**
 ARC (AUTOMATIC REFERENCE COUNTING)
  
 How it works ?
 
  Jab Bhi koi instance create hai kisi bhi class ka, ARC ek chunk of memory allocate karta hai jo us instance ki infomation store karta hai.
  Infomation jaise ki kis type ka instance hai kon koun si stored  properties associated hain.
  Or jab wo instance use ka nahi hota, to ARC memory free karne ka kaam bhi karta hai. Jisse ki wo memory koi or jagh use ki ja sake.
 
 
 
 
 // docs
 Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
 
 हर बार जब आप किसी वर्ग का एक नया उदाहरण बनाते हैं, तो एआरसी उस उदाहरण के बारे में जानकारी संग्रहीत करने के लिए मेमोरी का एक हिस्सा आवंटित करता है। यह मेमोरी इंस्टेंस के प्रकार के साथ-साथ उस इंस्टेंस से जुड़े किसी भी संग्रहीत गुणों के मूल्यों के बारे में जानकारी रखती है।
 
 Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead. This ensures that class instances don’t take up space in memory when they’re no longer needed.
 
 इसके अतिरिक्त, जब किसी इंस्टेंस की आवश्यकता नहीं रह जाती है, तो एआरसी उस इंस्टेंस द्वारा उपयोग की गई मेमोरी को मुक्त कर देता है ताकि मेमोरी का उपयोग इसके बजाय अन्य उद्देश्यों के लिए किया जा सके। यह सुनिश्चित करता है कि जब क्लास इंस्टेंसेस की आवश्यकता नहीं रह जाती है तो वे मेमोरी में जगह नहीं लेते हैं।

 However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.

 हालाँकि, यदि एआरसी को उस उदाहरण को हटा देना था जो अभी भी उपयोग में था, तो उस उदाहरण के गुणों तक पहुंचना, या उस उदाहरण के तरीकों को कॉल करना संभव नहीं होगा। वास्तव में, यदि आपने इंस्टेंस तक पहुंचने का प्रयास किया, तो संभवतः आपका ऐप क्रैश हो जाएगा।
 
 To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
 
 यह सुनिश्चित करने के लिए कि इंस्टेंस गायब न हो जाएं जबकि उनकी अभी भी आवश्यकता है, एआरसी ट्रैक करता है कि वर्तमान में प्रत्येक क्लास इंस्टेंस के लिए कितने गुण, स्थिरांक और चर संदर्भित हैं। एआरसी किसी इंस्टेंस को तब तक आवंटित नहीं करेगा जब तक उस इंस्टेंस का कम से कम एक सक्रिय संदर्भ अभी भी मौजूद है।

 To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.
 
 इसे संभव बनाने के लिए, जब भी आप किसी संपत्ति, स्थिरांक, या चर को एक वर्ग उदाहरण निर्दिष्ट करते हैं, तो वह संपत्ति, स्थिरांक, या चर उदाहरण के लिए एक मजबूत संदर्भ बनाता है। संदर्भ को "मजबूत" संदर्भ कहा जाता है क्योंकि यह उस उदाहरण पर मजबूत पकड़ रखता है, और जब तक वह मजबूत संदर्भ बना रहता है, तब तक उसे हटाए जाने की अनुमति नहीं देता है।
 */
