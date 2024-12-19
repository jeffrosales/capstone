//
//  NetworkService.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/14/24.
//

import Foundation
import CryptoKit

class NetworkService: NSObject, URLSessionDelegate {
    let pinnedKeyHashBase64 = "BASE64_OF_SERVER_PUBLIC_KEY_HASH"

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let trust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        // Get the certificate chain
        guard let certChain = SecTrustCopyCertificateChain(trust) as? [SecCertificate],
              let serverCert = certChain.first,
              let serverKey = SecCertificateCopyKey(serverCert),
              let serverKeyData = SecKeyCopyExternalRepresentation(serverKey, nil) as Data? else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        // Compute the SHA256 hash of the server's public key
        let hash = SHA256.hash(data: serverKeyData)
        let keyHashBase64 = Data(hash).base64EncodedString()

        if keyHashBase64 == pinnedKeyHashBase64 {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
