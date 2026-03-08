//
//  AccessManagementRepo.swift
//  CERQEL
//
//  Created by ahmed maher on 11/12/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation
internal import Promises

class AccessManagmentRepoImpl: AccessManagmentRepo {

    private var network: Network
    private var localData: LocalData

    init(network: Network = NetworkServiceImpl(), localData: LocalData = LocalDataImpl()) {
        self.network = network
        self.localData = localData
    }

    func getThemeWithConfiguration() -> Promise<BaseResponse<ThemeWithConfigurationDTO>> {
        return self.network.callModel(BaseResponse<ThemeWithConfigurationDTO>.self, endpoint: ThemeWithConfigurationEndPoint())
    }
    
    func getTenantList() -> Promise<BaseResponse<[TenantListDTO]>> {
        return self.network.callModel(BaseResponse<[TenantListDTO]>.self, endpoint: TenantListEndPoint())
    }


}
