// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AccountEarningsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AccountEarnings($ids: [ID!]!) {
      accounts(where: {id_in: $ids}) {
        __typename
        sharesSent {
          __typename
          tokenAmount
          vault {
            __typename
            id
          }
        }
        sharesReceived {
          __typename
          tokenAmount
          vault {
            __typename
            id
          }
        }
        deposits {
          __typename
          tokenAmount
          vault {
            __typename
            id
          }
        }
        withdrawals {
          __typename
          tokenAmount
          vault {
            __typename
            id
          }
        }
        vaultPositions {
          __typename
          balanceShares
          token {
            __typename
            id
            symbol
            decimals
          }
          shareToken {
            __typename
            id
            symbol
            decimals
          }
          vault {
            __typename
            id
            latestUpdate {
              __typename
              pricePerShare
            }
          }
        }
      }
    }
    """

  public let operationName: String = "AccountEarnings"

  public var ids: [GraphQLID]

  public init(ids: [GraphQLID]) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("accounts", arguments: ["where": ["id_in": GraphQLVariable("ids")]], type: .nonNull(.list(.nonNull(.object(Account.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(accounts: [Account]) {
      self.init(unsafeResultMap: ["__typename": "Query", "accounts": accounts.map { (value: Account) -> ResultMap in value.resultMap }])
    }

    public var accounts: [Account] {
      get {
        return (resultMap["accounts"] as! [ResultMap]).map { (value: ResultMap) -> Account in Account(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Account) -> ResultMap in value.resultMap }, forKey: "accounts")
      }
    }

    public struct Account: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Account"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("sharesSent", type: .nonNull(.list(.nonNull(.object(SharesSent.selections))))),
          GraphQLField("sharesReceived", type: .nonNull(.list(.nonNull(.object(SharesReceived.selections))))),
          GraphQLField("deposits", type: .nonNull(.list(.nonNull(.object(Deposit.selections))))),
          GraphQLField("withdrawals", type: .nonNull(.list(.nonNull(.object(Withdrawal.selections))))),
          GraphQLField("vaultPositions", type: .nonNull(.list(.nonNull(.object(VaultPosition.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(sharesSent: [SharesSent], sharesReceived: [SharesReceived], deposits: [Deposit], withdrawals: [Withdrawal], vaultPositions: [VaultPosition]) {
        self.init(unsafeResultMap: ["__typename": "Account", "sharesSent": sharesSent.map { (value: SharesSent) -> ResultMap in value.resultMap }, "sharesReceived": sharesReceived.map { (value: SharesReceived) -> ResultMap in value.resultMap }, "deposits": deposits.map { (value: Deposit) -> ResultMap in value.resultMap }, "withdrawals": withdrawals.map { (value: Withdrawal) -> ResultMap in value.resultMap }, "vaultPositions": vaultPositions.map { (value: VaultPosition) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Outgoing share transfers
      public var sharesSent: [SharesSent] {
        get {
          return (resultMap["sharesSent"] as! [ResultMap]).map { (value: ResultMap) -> SharesSent in SharesSent(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: SharesSent) -> ResultMap in value.resultMap }, forKey: "sharesSent")
        }
      }

      /// Incoming share transfers
      public var sharesReceived: [SharesReceived] {
        get {
          return (resultMap["sharesReceived"] as! [ResultMap]).map { (value: ResultMap) -> SharesReceived in SharesReceived(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: SharesReceived) -> ResultMap in value.resultMap }, forKey: "sharesReceived")
        }
      }

      /// Vault deposits
      public var deposits: [Deposit] {
        get {
          return (resultMap["deposits"] as! [ResultMap]).map { (value: ResultMap) -> Deposit in Deposit(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Deposit) -> ResultMap in value.resultMap }, forKey: "deposits")
        }
      }

      /// Vault withdrawals
      public var withdrawals: [Withdrawal] {
        get {
          return (resultMap["withdrawals"] as! [ResultMap]).map { (value: ResultMap) -> Withdrawal in Withdrawal(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Withdrawal) -> ResultMap in value.resultMap }, forKey: "withdrawals")
        }
      }

      /// Vault positions
      public var vaultPositions: [VaultPosition] {
        get {
          return (resultMap["vaultPositions"] as! [ResultMap]).map { (value: ResultMap) -> VaultPosition in VaultPosition(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: VaultPosition) -> ResultMap in value.resultMap }, forKey: "vaultPositions")
        }
      }

      public struct SharesSent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Transfer"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tokenAmount", type: .nonNull(.scalar(String.self))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tokenAmount: String, vault: Vault) {
          self.init(unsafeResultMap: ["__typename": "Transfer", "tokenAmount": tokenAmount, "vault": vault.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Number of Tokens redeemable for shares transferred
        public var tokenAmount: String {
          get {
            return resultMap["tokenAmount"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "tokenAmount")
          }
        }

        /// Vault
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID) {
            self.init(unsafeResultMap: ["__typename": "Vault", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }
      }

      public struct SharesReceived: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Transfer"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tokenAmount", type: .nonNull(.scalar(String.self))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tokenAmount: String, vault: Vault) {
          self.init(unsafeResultMap: ["__typename": "Transfer", "tokenAmount": tokenAmount, "vault": vault.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Number of Tokens redeemable for shares transferred
        public var tokenAmount: String {
          get {
            return resultMap["tokenAmount"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "tokenAmount")
          }
        }

        /// Vault
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID) {
            self.init(unsafeResultMap: ["__typename": "Vault", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }
      }

      public struct Deposit: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Deposit"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tokenAmount", type: .nonNull(.scalar(String.self))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tokenAmount: String, vault: Vault) {
          self.init(unsafeResultMap: ["__typename": "Deposit", "tokenAmount": tokenAmount, "vault": vault.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Number of Tokens deposited into Vault
        public var tokenAmount: String {
          get {
            return resultMap["tokenAmount"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "tokenAmount")
          }
        }

        /// Vault deposited into
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID) {
            self.init(unsafeResultMap: ["__typename": "Vault", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }
      }

      public struct Withdrawal: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Withdrawal"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tokenAmount", type: .nonNull(.scalar(String.self))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tokenAmount: String, vault: Vault) {
          self.init(unsafeResultMap: ["__typename": "Withdrawal", "tokenAmount": tokenAmount, "vault": vault.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Number of Tokens withdrawn from Vault
        public var tokenAmount: String {
          get {
            return resultMap["tokenAmount"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "tokenAmount")
          }
        }

        /// Vault withdrawn from
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID) {
            self.init(unsafeResultMap: ["__typename": "Vault", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }
      }

      public struct VaultPosition: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AccountVaultPosition"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("balanceShares", type: .nonNull(.scalar(String.self))),
            GraphQLField("token", type: .nonNull(.object(Token.selections))),
            GraphQLField("shareToken", type: .nonNull(.object(ShareToken.selections))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(balanceShares: String, token: Token, shareToken: ShareToken, vault: Vault) {
          self.init(unsafeResultMap: ["__typename": "AccountVaultPosition", "balanceShares": balanceShares, "token": token.resultMap, "shareToken": shareToken.resultMap, "vault": vault.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Share balance
        public var balanceShares: String {
          get {
            return resultMap["balanceShares"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "balanceShares")
          }
        }

        /// Vault token
        public var token: Token {
          get {
            return Token(unsafeResultMap: resultMap["token"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "token")
          }
        }

        /// Vault share token
        public var shareToken: ShareToken {
          get {
            return ShareToken(unsafeResultMap: resultMap["shareToken"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "shareToken")
          }
        }

        /// Vault
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        public struct Token: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Token"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("decimals", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, symbol: String, decimals: Int) {
            self.init(unsafeResultMap: ["__typename": "Token", "id": id, "symbol": symbol, "decimals": decimals])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Token address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// Symbol of the Token
          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          /// Number of decimals for this Token
          public var decimals: Int {
            get {
              return resultMap["decimals"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "decimals")
            }
          }
        }

        public struct ShareToken: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Token"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("decimals", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, symbol: String, decimals: Int) {
            self.init(unsafeResultMap: ["__typename": "Token", "id": id, "symbol": symbol, "decimals": decimals])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Token address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// Symbol of the Token
          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          /// Number of decimals for this Token
          public var decimals: Int {
            get {
              return resultMap["decimals"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "decimals")
            }
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("latestUpdate", type: .object(LatestUpdate.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, latestUpdate: LatestUpdate? = nil) {
            self.init(unsafeResultMap: ["__typename": "Vault", "id": id, "latestUpdate": latestUpdate.flatMap { (value: LatestUpdate) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault address
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// Latest Vault Update
          public var latestUpdate: LatestUpdate? {
            get {
              return (resultMap["latestUpdate"] as? ResultMap).flatMap { LatestUpdate(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "latestUpdate")
            }
          }

          public struct LatestUpdate: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["VaultUpdate"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("pricePerShare", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(pricePerShare: String) {
              self.init(unsafeResultMap: ["__typename": "VaultUpdate", "pricePerShare": pricePerShare])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Current price per full share
            public var pricePerShare: String {
              get {
                return resultMap["pricePerShare"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "pricePerShare")
              }
            }
          }
        }
      }
    }
  }
}

public final class AccountHistoricEarningsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AccountHistoricEarnings($ids: [ID!]!, $shareToken: String!, $fromDate: Int!) {
      accounts(where: {id_in: $ids}) {
        __typename
        vaultPositions(where: {shareToken: $shareToken}) {
          __typename
          balanceShares
          token {
            __typename
            decimals
          }
          vault {
            __typename
            vaultDayData(where: {date_gt: $fromDate}, orderBy: date, orderDirection: asc) {
              __typename
              pricePerShare
              date
            }
          }
          updates(orderBy: timestamp, orderDirection: asc) {
            __typename
            balanceShares
            timestamp
            deposits
            withdrawals
            tokensReceived
            tokensSent
          }
        }
      }
    }
    """

  public let operationName: String = "AccountHistoricEarnings"

  public var ids: [GraphQLID]
  public var shareToken: String
  public var fromDate: Int

  public init(ids: [GraphQLID], shareToken: String, fromDate: Int) {
    self.ids = ids
    self.shareToken = shareToken
    self.fromDate = fromDate
  }

  public var variables: GraphQLMap? {
    return ["ids": ids, "shareToken": shareToken, "fromDate": fromDate]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("accounts", arguments: ["where": ["id_in": GraphQLVariable("ids")]], type: .nonNull(.list(.nonNull(.object(Account.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(accounts: [Account]) {
      self.init(unsafeResultMap: ["__typename": "Query", "accounts": accounts.map { (value: Account) -> ResultMap in value.resultMap }])
    }

    public var accounts: [Account] {
      get {
        return (resultMap["accounts"] as! [ResultMap]).map { (value: ResultMap) -> Account in Account(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Account) -> ResultMap in value.resultMap }, forKey: "accounts")
      }
    }

    public struct Account: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Account"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("vaultPositions", arguments: ["where": ["shareToken": GraphQLVariable("shareToken")]], type: .nonNull(.list(.nonNull(.object(VaultPosition.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(vaultPositions: [VaultPosition]) {
        self.init(unsafeResultMap: ["__typename": "Account", "vaultPositions": vaultPositions.map { (value: VaultPosition) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Vault positions
      public var vaultPositions: [VaultPosition] {
        get {
          return (resultMap["vaultPositions"] as! [ResultMap]).map { (value: ResultMap) -> VaultPosition in VaultPosition(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: VaultPosition) -> ResultMap in value.resultMap }, forKey: "vaultPositions")
        }
      }

      public struct VaultPosition: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AccountVaultPosition"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("balanceShares", type: .nonNull(.scalar(String.self))),
            GraphQLField("token", type: .nonNull(.object(Token.selections))),
            GraphQLField("vault", type: .nonNull(.object(Vault.selections))),
            GraphQLField("updates", arguments: ["orderBy": "timestamp", "orderDirection": "asc"], type: .nonNull(.list(.nonNull(.object(Update.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(balanceShares: String, token: Token, vault: Vault, updates: [Update]) {
          self.init(unsafeResultMap: ["__typename": "AccountVaultPosition", "balanceShares": balanceShares, "token": token.resultMap, "vault": vault.resultMap, "updates": updates.map { (value: Update) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Share balance
        public var balanceShares: String {
          get {
            return resultMap["balanceShares"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "balanceShares")
          }
        }

        /// Vault token
        public var token: Token {
          get {
            return Token(unsafeResultMap: resultMap["token"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "token")
          }
        }

        /// Vault
        public var vault: Vault {
          get {
            return Vault(unsafeResultMap: resultMap["vault"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "vault")
          }
        }

        /// Account updates over time
        public var updates: [Update] {
          get {
            return (resultMap["updates"] as! [ResultMap]).map { (value: ResultMap) -> Update in Update(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Update) -> ResultMap in value.resultMap }, forKey: "updates")
          }
        }

        public struct Token: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Token"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("decimals", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(decimals: Int) {
            self.init(unsafeResultMap: ["__typename": "Token", "decimals": decimals])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Number of decimals for this Token
          public var decimals: Int {
            get {
              return resultMap["decimals"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "decimals")
            }
          }
        }

        public struct Vault: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Vault"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("vaultDayData", arguments: ["where": ["date_gt": GraphQLVariable("fromDate")], "orderBy": "date", "orderDirection": "asc"], type: .nonNull(.list(.nonNull(.object(VaultDayDatum.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(vaultDayData: [VaultDayDatum]) {
            self.init(unsafeResultMap: ["__typename": "Vault", "vaultDayData": vaultDayData.map { (value: VaultDayDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Vault Daily Data
          public var vaultDayData: [VaultDayDatum] {
            get {
              return (resultMap["vaultDayData"] as! [ResultMap]).map { (value: ResultMap) -> VaultDayDatum in VaultDayDatum(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: VaultDayDatum) -> ResultMap in value.resultMap }, forKey: "vaultDayData")
            }
          }

          public struct VaultDayDatum: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["VaultDayData"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("pricePerShare", type: .nonNull(.scalar(String.self))),
                GraphQLField("date", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(pricePerShare: String, date: Int) {
              self.init(unsafeResultMap: ["__typename": "VaultDayData", "pricePerShare": pricePerShare, "date": date])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var pricePerShare: String {
              get {
                return resultMap["pricePerShare"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "pricePerShare")
              }
            }

            public var date: Int {
              get {
                return resultMap["date"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "date")
              }
            }
          }
        }

        public struct Update: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["AccountVaultPositionUpdate"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("balanceShares", type: .nonNull(.scalar(String.self))),
              GraphQLField("timestamp", type: .nonNull(.scalar(String.self))),
              GraphQLField("deposits", type: .nonNull(.scalar(String.self))),
              GraphQLField("withdrawals", type: .nonNull(.scalar(String.self))),
              GraphQLField("tokensReceived", type: .nonNull(.scalar(String.self))),
              GraphQLField("tokensSent", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(balanceShares: String, timestamp: String, deposits: String, withdrawals: String, tokensReceived: String, tokensSent: String) {
            self.init(unsafeResultMap: ["__typename": "AccountVaultPositionUpdate", "balanceShares": balanceShares, "timestamp": timestamp, "deposits": deposits, "withdrawals": withdrawals, "tokensReceived": tokensReceived, "tokensSent": tokensSent])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The balance of shares
          public var balanceShares: String {
            get {
              return resultMap["balanceShares"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "balanceShares")
            }
          }

          /// Timestamp
          public var timestamp: String {
            get {
              return resultMap["timestamp"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "timestamp")
            }
          }

          /// Sum of token deposits
          public var deposits: String {
            get {
              return resultMap["deposits"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "deposits")
            }
          }

          /// Sum of token withdrawals
          public var withdrawals: String {
            get {
              return resultMap["withdrawals"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "withdrawals")
            }
          }

          public var tokensReceived: String {
            get {
              return resultMap["tokensReceived"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "tokensReceived")
            }
          }

          public var tokensSent: String {
            get {
              return resultMap["tokensSent"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "tokensSent")
            }
          }
        }
      }
    }
  }
}
