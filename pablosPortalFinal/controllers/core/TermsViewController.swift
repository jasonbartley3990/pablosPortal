//
//  TermsViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit
import SafariServices

class TermsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let introText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Pablos portal"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Pablos Portal terms and conditions"
        return label
    }()
    
    private let introTextPart2: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "terms and conditions"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Pablos Portal terms and conditions"
        return label
    }()
    
    
    private let effectiveDateText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "effective July 28 2021"
        label.isAccessibilityElement = true
        label.accessibilityValue = "effective July 28 2021"
        return label
    }()
    
    private let agreementToTermsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Agreement To Terms"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Agreement to terms"
        return label
    }()
    
    
    private let agreementToTermsText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity ('you') and Pablos Portal ('we,' 'us' or 'our']), concerning your access to and use of the Pablos Portal app as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, Pablos).\n\nYou agree that by accessing the app, you have read, understood, and agree to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the app and you must discontinue use immediately.\n\n We reserve the right, in our sole discretion, to make changes or modifications to these Terms and Conditions at any time and for any reason.\n\n We will alert you about any changes by updating the “Last updated” date of these Terms and Conditions, and you waive any right to receive specific notice of each such change.\n\nIt is your responsibility to periodically review these Terms and Conditions to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Terms and Conditions by your continued use of the app after the date such revised Terms and Conditions are posted.\n\nThe information provided on the app is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country.\n\n Accordingly, those persons who choose to access the app from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.\n\n [The app is intended for users who are at least 13 years of age.] All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Site. If you are a minor, you must have your parent or guardian read and agree to these Terms and Conditions prior to you using the App."
        label.isAccessibilityElement = true
        label.accessibilityValue = "These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity ('you') and Pablos Portal ('we,' 'us' or 'our']), concerning your access to and use of the Pablos Portal app as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, Pablos).\n\nYou agree that by accessing the app, you have read, understood, and agree to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the app and you must discontinue use immediately.\n\n We reserve the right, in our sole discretion, to make changes or modifications to these Terms and Conditions at any time and for any reason.\n\n We will alert you about any changes by updating the “Last updated” date of these Terms and Conditions, and you waive any right to receive specific notice of each such change.\n\nIt is your responsibility to periodically review these Terms and Conditions to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Terms and Conditions by your continued use of the app after the date such revised Terms and Conditions are posted.\n\nThe information provided on the app is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country.\n\n Accordingly, those persons who choose to access the app from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.\n\n [The app is intended for users who are at least 13 years of age.] All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Site. If you are a minor, you must have your parent or guardian read and agree to these Terms and Conditions prior to you using the App."
        return label
    }()
    
    private let intellectualPropertyRightsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Intellectual Property Rights"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Intellectual Property Rights"
        return label
    }()
    
    private let intectualPropertyText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "Unless otherwise indicated, the app is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the app (collectively, the “Content”) and the trademarks, service marks, and logos contained therein (the “Marks”) are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the United States, foreign jurisdictions, and international conventions.\n\nThe Content and the Marks are provided on the app “AS IS” for your information and personal use only. Except as expressly provided in these Terms and Conditions, no part of the app and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.\n\nProvided that you are eligible to use the app, you are granted a limited license to access and use the app and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the app, the Content and the Marks."
        label.isAccessibilityElement = true
        label.accessibilityValue = "Unless otherwise indicated, the app is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the app (collectively, the “Content”) and the trademarks, service marks, and logos contained therein (the “Marks”) are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the United States, foreign jurisdictions, and international conventions.\n\nThe Content and the Marks are provided on the app “AS IS” for your information and personal use only. Except as expressly provided in these Terms and Conditions, no part of the app and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.\n\nProvided that you are eligible to use the app, you are granted a limited license to access and use the app and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the app, the Content and the Marks."
        return label
    }()
    
    private let userRepresentationTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "User Representation"
        label.isAccessibilityElement = true
        label.accessibilityValue = "User Representation"
        return label
    }()
    
    private let userRepresentationText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "By using the app, you represent and warrant that:\n[(1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary;]\n(3) you have the legal capacity and you agree to comply with these Terms and Conditions;\n[(4) you are not under the age of 13;]\n(5) not a minor in the jurisdiction in which you reside [, or if a minor, you have received parental permission to use the app];\n(6) you will not access the app through automated or non-human means, whether through a bot, script, or otherwise;\n(7) you will not use the app for any illegal or unauthorized purpose;\n(8) your use of the Site will not violate any applicable law or regulation.\nIf you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the app (or any portion thereof)."
        label.isAccessibilityElement = true
        label.accessibilityValue = "By using the app, you represent and warrant that:\n[(1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary;]\n(3) you have the legal capacity and you agree to comply with these Terms and Conditions;\n[(4) you are not under the age of 13;]\n(5) not a minor in the jurisdiction in which you reside [, or if a minor, you have received parental permission to use the app];\n(6) you will not access the app through automated or non-human means, whether through a bot, script, or otherwise;\n(7) you will not use the app for any illegal or unauthorized purpose;\n(8) your use of the Site will not violate any applicable law or regulation.\nIf you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the app (or any portion thereof)."
        return label
    }()
    
    private let restictedActivitiesTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Restricted Activities"
        return label
    }()
    
    private let restictedActivitiesText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 0
        label.text = "You may not access or use the Site for any purpose other than that for which we make the Site available. The Site may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.\nAs a user of the Site, you agree not to:\n1.systematically retrieve data or other content from the Site to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.\n2.make any unauthorized use of the Site, including collecting email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.\n3.use a buying agent or purchasing agent to make purchases on the App.\n4.use the App to advertise or offer to sell goods and services.\n5.circumvent, disable, or otherwise interfere with security-related features of the Site, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the App and/or the Content contained therein.\n6.engage in unauthorized framing of or linking to the Site.\n7.trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords\n8.make improper use of our support services or submit false reports of abuse or misconduct.\n9.engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.\n10.interfere with, disrupt, or create an undue burden on the App or the networks or services connected to the App.\n11.attempt to impersonate another user or person or use the username of another user.\n12.sell or otherwise transfer your profile.\n13.use any information obtained from the App in order to harass, abuse, or harm another person.\n15.use the App as part of any effort to compete with us or otherwise use the App and/or the Content for any revenue-generating endeavor or commercial enterprise.\n16.decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Site.\n17.attempt to bypass any measures of the Site designed to prevent or restrict access to the Site, or any portion of the Site.\n18.harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Site to you.\n19.delete the copyright or other proprietary rights notice from any Content.\n20.copy or adapt the Site’s software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.\n21.upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the App or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Site.\n22.upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats (“gifs”), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as “spyware” or “passive collection mechanisms” or “pcms”).\n23.except as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Site, or using or launching any unauthorized script or other software.\n24.disparage, tarnish, or otherwise harm, in our opinion, us and/or the Site.\n25.use the Site in a manner inconsistent with any applicable laws or regulations."
        label.isAccessibilityElement = true
        label.accessibilityValue = "You may not access or use the Site for any purpose other than that for which we make the Site available. The Site may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.\nAs a user of the Site, you agree not to:\n1.systematically retrieve data or other content from the Site to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.\n2.make any unauthorized use of the Site, including collecting email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.\n3.use a buying agent or purchasing agent to make purchases on the App.\n4.use the App to advertise or offer to sell goods and services.\n5.circumvent, disable, or otherwise interfere with security-related features of the Site, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the App and/or the Content contained therein.\n6.engage in unauthorized framing of or linking to the Site.\n7.trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords\n8.make improper use of our support services or submit false reports of abuse or misconduct.\n9.engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.\n10.interfere with, disrupt, or create an undue burden on the App or the networks or services connected to the App.\n11.attempt to impersonate another user or person or use the username of another user.\n12.sell or otherwise transfer your profile.\n13.use any information obtained from the App in order to harass, abuse, or harm another person.\n15.use the App as part of any effort to compete with us or otherwise use the App and/or the Content for any revenue-generating endeavor or commercial enterprise.\n16.decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Site.\n17.attempt to bypass any measures of the Site designed to prevent or restrict access to the Site, or any portion of the Site.\n18.harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Site to you.\n19.delete the copyright or other proprietary rights notice from any Content.\n20.copy or adapt the Site’s software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.\n21.upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the App or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Site.\n22.upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats (“gifs”), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as “spyware” or “passive collection mechanisms” or “pcms”).\n23.except as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Site, or using or launching any unauthorized script or other software.\n24.disparage, tarnish, or otherwise harm, in our opinion, us and/or the Site.\n25.use the Site in a manner inconsistent with any applicable laws or regulations."
        return label
    }()
    
    private let mobileApplicationLicenseTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Mobile Application License"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Mobile Application License"
        return label
    }()
    
    
    private let mobileApplicationLicenseText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "If you access the App via a mobile application, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the mobile application on wireless electronic devices owned or controlled by you, and to access and use the mobile application on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Terms and Conditions.\nYou shall not:\n(1) decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the application;\n(2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the application;\n(3) violate any applicable laws, rules, or regulations in connection with your access or use of the application;\n(4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the application;\n(5) use the application for any revenue generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended;\n(6) make the application available over a network or other environment permitting access or use by multiple devices or users at the same time;\n(7) use the application for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the application;\n(8) use the application to send automated queries to any website or to send any unsolicited commercial e-mail;\n(9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the application"
        label.isAccessibilityElement = true
        label.accessibilityValue = "If you access the App via a mobile application, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the mobile application on wireless electronic devices owned or controlled by you, and to access and use the mobile application on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Terms and Conditions.\nYou shall not:\n(1) decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the application;\n(2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the application;\n(3) violate any applicable laws, rules, or regulations in connection with your access or use of the application;\n(4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the application;\n(5) use the application for any revenue generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended;\n(6) make the application available over a network or other environment permitting access or use by multiple devices or users at the same time;\n(7) use the application for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the application;\n(8) use the application to send automated queries to any website or to send any unsolicited commercial e-mail;\n(9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the application"
        return label
    }()
    
    private let thirdPartyTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Third-party website and content"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Third-party website and content"
        return label
    }()
    
    private let thirdPartyText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "The app may contain (or you may be sent via the Site) links to other websites (“Third-Party Websites”) as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties (“Third-Party Content”).\nSuch Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the app or any Third-Party Content posted on, available through, or installed from the app, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content.\nInclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Site and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Terms and Conditions no longer govern.\nYou should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the app or relating to any applications you use or install from the app. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party.\nYou agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us harmless from any harm caused by your purchase of such products or services. Additionally, you shall hold us harmless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites."
        label.isAccessibilityElement = true
        label.accessibilityValue = "The app may contain (or you may be sent via the Site) links to other websites (“Third-Party Websites”) as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties (“Third-Party Content”).\nSuch Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the app or any Third-Party Content posted on, available through, or installed from the app, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content.\nInclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Site and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Terms and Conditions no longer govern.\nYou should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the app or relating to any applications you use or install from the app. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party.\nYou agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us harmless from any harm caused by your purchase of such products or services. Additionally, you shall hold us harmless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites."
        return label
    }()
    
    private let deliveryTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "delivery"
        label.isAccessibilityElement = true
        label.accessibilityValue = "delivery"
        return label
    }()
    
    private let deliveryText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "deliverys will take anywhere between 1 week and 1 month to ship.we go through a third party for delivery. we are not responsible for items lost in transit, or items broken or malformed in transit"
        label.isAccessibilityElement = true
        label.accessibilityValue = "deliverys will take anywhere between 1 week and 1 month to ship.we go through a third party for delivery. we are not responsible for items lost in transit, or items broken or malformed in transit"
        return label
    }()
    
    
    private let returnsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "returns"
        label.isAccessibilityElement = true
        label.accessibilityValue = "returns"
        return label
    }()
    
    private let returnsText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 8
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "if you recieved a item you did not purchase, please contact (pablosportal6@gmail.com), or report the issue in the app. we are not responsible for items broken or malformed in transit. we will ship the correct item to you within 1 week or 1 month of shippment date."
        label.isAccessibilityElement = true
        label.accessibilityValue = "if you recieved a item you did not purchase, please contact (pablosportal6@gmail.com), or report the issue in the app. we are not responsible for items broken or malformed in transit. we will ship the correct item to you within 1 week or 1 month of shippment date."
        return label
    }()
    
    private let refundsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "refunds"
        label.isAccessibilityElement = true
        label.accessibilityValue = "refunds"
        return label
    }()
    
    private let refundsText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "all sales are final, if the item you recieved was not what you purchased, and you do not wish to recieve correct item, we will refund you funds in full."
        label.isAccessibilityElement = true
        label.accessibilityValue = "all sales are final, if the item you recieved was not what you purchased, and you do not wish to recieve correct item, we will refund you funds in full."
        return label
    }()
    
    private let productLiabiliesTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "product liabilitys"
        label.isAccessibilityElement = true
        label.accessibilityValue = "product liabilitys"
        return label
    }()
    
    private let productLiabilitysText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "if the product you purchase has caused physical harm to you we are not responsible. The safety of yourself, is solely your responsibilty"
        label.isAccessibilityElement = true
        label.accessibilityValue = "if the product you purchase has caused physical harm to you we are not responsible. The safety of yourself, is solely your responsibilty"
        return label
    }()
    
    private let appManagementTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "App management"
        label.isAccessibilityElement = true
        label.accessibilityValue = "App management"
        return label
    }()
    
    private let appManagementText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text =  "We reserve the right, but not the obligation, to:\n(1) monitor the app for violations of these Terms and Conditions;\n(2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Terms and Conditions, including without limitation, reporting such user to law enforcement authorities;\n(3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof;\n(4) in our sole discretion and without limitation, notice, or liability, to remove from the Site or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems;\n(5) otherwise manage the app in a manner designed to protect our rights and property and to facilitate the proper functioning of the Site."
        label.isAccessibilityElement = true
        label.accessibilityValue = "We reserve the right, but not the obligation, to:\n(1) monitor the app for violations of these Terms and Conditions;\n(2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Terms and Conditions, including without limitation, reporting such user to law enforcement authorities;\n(3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof;\n(4) in our sole discretion and without limitation, notice, or liability, to remove from the Site or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems;\n(5) otherwise manage the app in a manner designed to protect our rights and property and to facilitate the proper functioning of the Site."
        return label
    }()
    
    private let copyrightTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "copyright infringement"
        label.isAccessibilityElement = true
        label.accessibilityValue = "copyright infringement"
        return label
    }()
    
    private let copyrightText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "We respect the intellectual property rights of others. If you believe that any material available on or through the app infringes upon any copyright you own or control, please immediately notify us using the contact information provided (pablosportal6@gmail.com). The user will be contacted and addressed."
        label.isAccessibilityElement = true
        label.accessibilityValue = "We respect the intellectual property rights of others. If you believe that any material available on or through the app infringes upon any copyright you own or control, please immediately notify us using the contact information provided (pablosportal6@gmail.com). The user will be contacted and addressed."
        return label
    }()
    
    private let termsTerminationTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "TERMS AND TERMINATION"
        label.isAccessibilityElement = true
        label.accessibilityValue = "TERMS AND TERMINATION"
        return label
    }()
    
    private let termTerminationText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "These Terms and Conditions shall remain in full force and effect while you use the app. WITHOUT LIMITING ANY OTHER PROVISION OF THESE TERMS AND CONDITIONS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SITE (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE TERMS AND CONDITIONS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SITE OR DELETE [YOUR ACCOUNT AND] ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.\n\nIf we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party.\n\nIn addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress."
        label.isAccessibilityElement = true
        label.accessibilityValue = "These Terms and Conditions shall remain in full force and effect while you use the app. WITHOUT LIMITING ANY OTHER PROVISION OF THESE TERMS AND CONDITIONS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SITE (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE TERMS AND CONDITIONS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SITE OR DELETE [YOUR ACCOUNT AND] ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.\n\nIf we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party.\n\nIn addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress."
        return label
    }()
    
    private let modificationsInteruptionsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "modifications interuptions"
        label.isAccessibilityElement = true
        label.accessibilityValue = "modifications interuptions"
        return label
    }()
    
    private let termsTerminationText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "We reserve the right to change, modify, or remove the contents of the Site at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our app. We also reserve the right to modify or discontinue all or part of the app without notice at any time.\n\nWe will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the app.\n\nWe cannot guarantee the app will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Site, resulting in interruptions, delays, or errors.\n\nWe reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Site at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the app during any downtime or discontinuance of the App.\n\nNothing in these Terms and Conditions will be construed to obligate us to maintain and support the Site or to supply any corrections, updates, or releases in connection therewith."
        label.isAccessibilityElement = true
        label.accessibilityValue = "We reserve the right to change, modify, or remove the contents of the Site at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our app. We also reserve the right to modify or discontinue all or part of the app without notice at any time.\n\nWe will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the app.\n\nWe cannot guarantee the app will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Site, resulting in interruptions, delays, or errors.\n\nWe reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Site at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the app during any downtime or discontinuance of the App.\n\nNothing in these Terms and Conditions will be construed to obligate us to maintain and support the Site or to supply any corrections, updates, or releases in connection therewith."
        return label
    }()
    
    private let governingLawTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Governing law"
        label.isAccessibilityElement = true
        label.accessibilityValue = "governing law"
        return label
    }()
    
    private let governingLawText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "These Terms and Conditions and your use of the app are governed by and construed in accordance with the laws of the State of Texas applicable to agreements made and to be entirely performed within the State/Commonwealth of Texas, without regard to its conflict of law principles."
        label.isAccessibilityElement = true
        label.accessibilityValue = "These Terms and Conditions and your use of the app are governed by and construed in accordance with the laws of the State of Texas applicable to agreements made and to be entirely performed within the State/Commonwealth of Texas, without regard to its conflict of law principles."
        return label
    }()
    
    private let disclaimerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Disclaimer"
        label.isAccessibilityElement = true
        label.accessibilityValue = "disclaimer"
        return label
    }()
    
    private let disclaimerText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = " THE APP IS PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SITE AND OUR SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE APP AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE APPS’S CONTENT OR THE CONTENT OF ANY WEBSITES LINKED TO THE APP AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SITE, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE APP, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SITE BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE APP. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SITE, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES.\n\nAS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE."
        label.isAccessibilityElement = true
        label.accessibilityValue = " THE APP IS PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SITE AND OUR SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE APP AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE APPS’S CONTENT OR THE CONTENT OF ANY WEBSITES LINKED TO THE APP AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SITE, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE APP, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SITE BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE APP. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SITE, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES.\n\nAS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE."
        return label
    }()
    
    private let limitationsLiabilityTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Limitations of liability"
        label.isAccessibilityElement = true
        label.accessibilityValue = "limitations of liability"
        return label
    }()
    
    private let limitationsLiabilityText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE APP, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.\n\n[NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO [THE LESSER OF] [THE AMOUNT PAID, IF ANY, BY YOU TO US DURING THE [_________] MONTH PERIOD PRIOR TO ANY CAUSE OF ACTION ARISING [OR] [$_________]. CERTAIN STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES.\n\nIF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.]"
        label.isAccessibilityElement = true
        label.accessibilityValue = "IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE APP, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.\n\n[NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO [THE LESSER OF] [THE AMOUNT PAID, IF ANY, BY YOU TO US DURING THE _____ MONTH PERIOD PRIOR TO ANY CAUSE OF ACTION ARISING [OR] _____. CERTAIN STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES.\n\nIF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.]"
        return label
    }()
    
    private let userDataTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "User Data"
        label.isAccessibilityElement = true
        label.accessibilityValue = "User data"
        return label
    }()
    
    private let userDataText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "We will maintain certain data that you transmit to the App for the purpose of managing the App, as well as data relating to your use of the App. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the App.\n\nYou agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data."
        label.isAccessibilityElement = true
        label.accessibilityValue = "We will maintain certain data that you transmit to the App for the purpose of managing the App, as well as data relating to your use of the App. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the App.\n\nYou agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data."
        return label
    }()
    
    private let commTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Electronic communications, transactions and signitures"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Electronic communications, transactions and signitures"
        return label
    }()
    
    private let commText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "Visiting the app, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communication be in writing.\n\nYOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SITE.\n\nYou hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means."
        label.isAccessibilityElement = true
        label.accessibilityValue = "Visiting the app, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communication be in writing.\n\nYOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SITE.\n\nYou hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means."
        return label
    }()
    
    private let miscTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "MISCELLANEOUS"
        label.isAccessibilityElement = true
        label.accessibilityValue = "MISCELLANEOUS"
        return label
    }()
    
    private let miscText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.text = "These Terms and Conditions and any policies or operating rules posted by us on the Site constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Terms and Conditions shall not operate as a waiver of such right or provision.\n\nThese Terms and Conditions operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control.\n\nIf any provision or part of a provision of these Terms and Conditions is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Terms and Conditions and does not affect the validity and enforceability of any remaining provisions.\n\nThere is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Terms and Conditions or use of the Site. You agree that these Terms and Conditions will not be construed against us by virtue of having drafted them.\n\nYou hereby waive any and all defenses you may have based on the electronic form of these Terms and Conditions and the lack of signing by the parties hereto to execute these Terms and Conditions."
        label.isAccessibilityElement = true
        label.accessibilityValue = "These Terms and Conditions and any policies or operating rules posted by us on the Site constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Terms and Conditions shall not operate as a waiver of such right or provision.\n\nThese Terms and Conditions operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control.\n\nIf any provision or part of a provision of these Terms and Conditions is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Terms and Conditions and does not affect the validity and enforceability of any remaining provisions.\n\nThere is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Terms and Conditions or use of the Site. You agree that these Terms and Conditions will not be construed against us by virtue of having drafted them.\n\nYou hereby waive any and all defenses you may have based on the electronic form of these Terms and Conditions and the lack of signing by the parties hereto to execute these Terms and Conditions."
        return label
    }()
    
    private let contactTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Contact us"
        label.isAccessibilityElement = true
        label.accessibilityValue = "Contact us"
        return label
    }()
    
    private let contactText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "contact us at pablosportal6@gmail.com"
        label.isAccessibilityElement = true
        label.accessibilityValue = "contact us at pablosportal6@gmail.com"
        return label
    }()
    
    
    private let privacyTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "To view Pablos Portal privacy policy"
        label.isAccessibilityElement = true
        label.accessibilityValue = "to view pablos portal privacy policy click link below"
        label.accessibilityHint = "text displaying that if you want to view privacy policy tap link below"
        return label
    }()
    
    private let privacyTitlePart2: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "click the link below"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("privacy Policy", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.isAccessibilityElement = true
        button.accessibilityValue = "tap here to view privacy policy"
        button.accessibilityHint = "tap here to view privacy policy"
        return button
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "terms & conditions"
        view.addSubview(scrollView)
        view.addSubview(button)
        view.addSubview(privacyTitle)
        view.addSubview(privacyTitlePart2)
        button.addTarget(self, action: #selector(didTapPP), for: .touchUpInside)
        setUpScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width-40, height: ((view.height/4)*3) - 30)
        privacyTitle.frame = CGRect(x: 20, y: scrollView.bottom + 7, width: view.width - 40, height: 20)
        privacyTitlePart2.frame = CGRect(x: 20, y: privacyTitle.bottom + 5, width: view.width - 40, height: 20)
        button.frame = CGRect(x: 30, y: privacyTitlePart2.bottom + 7, width: view.width - 60, height: 20)
    }
    
    private func setUpScrollView() {
        scrollView.contentSize = CGSize(width: view.width - 40, height: (16000))
        
        scrollView.addSubview(introText)
        introText.frame = CGRect(x: 25, y: introText.top + 20, width: view.width - 80, height: 20)
        scrollView.addSubview(introTextPart2)
        introTextPart2.frame = CGRect(x: 25, y: introText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(effectiveDateText)
        effectiveDateText.frame = CGRect(x: 25, y: introTextPart2.bottom + 15, width: view.width - 80, height: 20)
        scrollView.addSubview(agreementToTermsTitle)
        agreementToTermsTitle.frame = CGRect(x: 25, y: effectiveDateText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(agreementToTermsText)
        agreementToTermsText.frame = CGRect(x: 25, y: agreementToTermsTitle.bottom + 10, width: view.width - 80, height: 1440)
        scrollView.addSubview(intellectualPropertyRightsTitle)
        intellectualPropertyRightsTitle.frame = CGRect(x: 25, y: agreementToTermsText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(intectualPropertyText)
        intectualPropertyText.frame = CGRect(x: 25, y: intellectualPropertyRightsTitle.bottom + 10, width: view.width - 80, height: 820)
        scrollView.addSubview(userRepresentationTitle)
        userRepresentationTitle.frame = CGRect(x: 25, y: intectualPropertyText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(userRepresentationText)
        userRepresentationText.frame = CGRect(x: 25, y: userRepresentationTitle.bottom + 10, width: view.width - 80, height: 670)
        scrollView.addSubview(restictedActivitiesTitle)
        restictedActivitiesTitle.frame = CGRect(x: 25, y: userRepresentationText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(restictedActivitiesText)
        restictedActivitiesText.frame = CGRect(x: 25, y: restictedActivitiesTitle.bottom + 10, width: view.width - 80, height: 2210)
        scrollView.addSubview(returnsTitle)
        returnsTitle.frame = CGRect(x: 25, y: restictedActivitiesText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(returnsText)
        returnsText.frame = CGRect(x: 25, y: returnsTitle.bottom + 10, width: view.width-80, height: 190)
        scrollView.addSubview(deliveryTitle)
        deliveryTitle.frame = CGRect(x: 25, y: returnsText.bottom + 10 , width: view.width - 80, height: 20)
        scrollView.addSubview(deliveryText)
        deliveryText.frame = CGRect(x: 25, y: deliveryTitle.bottom + 10, width: view.width - 80, height: 150)
        scrollView.addSubview(refundsTitle)
        refundsTitle.frame = CGRect(x: 25, y: deliveryText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(refundsText)
        refundsText.frame = CGRect(x: 25, y: refundsTitle.bottom + 10, width: view.width - 80, height: 140)
        scrollView.addSubview(productLiabiliesTitle)
        productLiabiliesTitle.frame = CGRect(x: 25, y: refundsText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(productLiabilitysText)
        productLiabilitysText.frame = CGRect(x: 25, y: productLiabiliesTitle.bottom + 10, width: view.width - 80, height: 140)
        scrollView.addSubview(mobileApplicationLicenseTitle)
        mobileApplicationLicenseTitle.frame = CGRect(x: 25, y: productLiabilitysText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(mobileApplicationLicenseText)
        mobileApplicationLicenseText.frame = CGRect(x: 25, y: mobileApplicationLicenseTitle.bottom + 10, width: view.width - 80, height: 1020)
        scrollView.addSubview(thirdPartyTitle)
        thirdPartyTitle.frame = CGRect(x: 25, y: mobileApplicationLicenseText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(thirdPartyText)
        thirdPartyText.frame = CGRect(x: 25, y: thirdPartyTitle.bottom + 10, width: view.width - 80, height: 1100)
        scrollView.addSubview(appManagementTitle)
        appManagementTitle.frame = CGRect(x: 25, y: thirdPartyText.bottom + 20, width: view.width - 80, height: 20)
        scrollView.addSubview(appManagementText)
        appManagementText.frame = CGRect(x: 25, y: appManagementTitle.bottom + 10, width: view.width - 80, height: 580)
        scrollView.addSubview(copyrightTitle)
        copyrightTitle.frame = CGRect(x: 25, y: appManagementText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(copyrightText)
        copyrightText.frame = CGRect(x: 25, y: copyrightTitle.bottom + 10, width: view.width - 80, height: 160)
        scrollView.addSubview(termsTerminationTitle)
        termsTerminationTitle.frame = CGRect(x: 25, y: copyrightText.bottom + 30, width: view.width - 80, height: 20)
        scrollView.addSubview(termsTerminationText)
        termsTerminationText.frame = CGRect(x: 25, y: termsTerminationTitle.bottom + 10, width: view.width - 80, height: 800)
        scrollView.addSubview(governingLawTitle)
        governingLawTitle.frame = CGRect(x: 25, y: termsTerminationText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(governingLawText)
        governingLawText.frame = CGRect(x: 25, y: governingLawTitle.bottom + 10, width: view.width - 80, height: 240)
        scrollView.addSubview(disclaimerTitle)
        disclaimerTitle.frame = CGRect(x: 25, y: governingLawText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(disclaimerText)
        disclaimerText.frame = CGRect(x: 25, y: disclaimerTitle.bottom + 10, width: view.width - 80, height: 1320)
        scrollView.addSubview(limitationsLiabilityTitle)
        limitationsLiabilityTitle.frame = CGRect(x: 25, y: disclaimerText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(limitationsLiabilityText)
        limitationsLiabilityText.frame = CGRect(x: 25, y: limitationsLiabilityTitle.bottom + 10, width: view.width - 80, height: 730)
        scrollView.addSubview(userDataTitle)
        userDataTitle.frame = CGRect(x: 25, y: limitationsLiabilityText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(userDataText)
        userDataText.frame = CGRect(x: 25, y: userDataTitle.bottom + 10, width: view.width - 80, height: 300)
        scrollView.addSubview(commTitle)
        commTitle.frame = CGRect(x: 25, y: userDataText.bottom + 10, width: view.width - 80, height: 50)
        scrollView.addSubview(commText)
        commText.frame = CGRect(x: 25, y: commTitle.bottom + 10, width: view.width - 80, height: 600)
        scrollView.addSubview(miscTitle)
        miscTitle.frame = CGRect(x: 25, y: commText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(miscText)
        miscText.frame =  CGRect(x: 25, y: miscTitle.bottom + 10, width: view.width - 80, height: 800)
        scrollView.addSubview(contactTitle)
        contactTitle.frame = CGRect(x: 25, y: miscText.bottom + 10, width: view.width - 80, height: 20)
        scrollView.addSubview(contactText)
        contactText.frame = CGRect(x: 25, y: contactTitle.bottom + 10, width: view.width - 80, height: 50)
        
        
    }
    
    @objc func didTapPP() {
        let website = "https://www.privacypolicies.com/live/96750e95-8f90-4afe-ade2-294d45fea646"
        let result = urlOpener.shared.verifyUrl(urlString: website)
        if result == true {
            if let url = URL(string: website ) {
                let vc = SFSafariViewController(url: url)
                self.present(vc, animated: true)
            }
        } else {
            print("cant open url")
            let ac = UIAlertController(title: "invalid url", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(ac, animated: true)
        }
        
    }
}
