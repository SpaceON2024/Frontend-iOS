import SwiftUI
import Alamofire

struct GroupCreationModal: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager
    @State private var groupName: String = ""
    @State private var groupDescription: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("그룹명", text: $groupName)
                TextField("그룹 설명", text: $groupDescription)
            }
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                },
                trailing: Button("생성") {
                    createGroup()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func createGroup() {
        guard let accessToken = userManager.userInfo?.tokens.accessToken else {
            print("Error: Access token is missing")
            return
        }
        
        let url = "https://spaceon.kro.kr/api/v1/group/new"
        let parameters = GroupData(groupName: groupName, groupContent: groupDescription)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                if let error = response.error {
                    print("Error: \(error.localizedDescription)")
                } else if let statusCode = response.response?.statusCode, 200..<300 ~= statusCode {
                    print("Group created successfully")
                } else {
                    print("Failed with status code: \(response.response?.statusCode ?? 0)")
                }
            }
    }
}

// GroupData 구조체 정의
struct GroupData: Encodable {
    let groupName: String
    let groupContent: String
}

#Preview {
    GroupCreationModal()
        .environmentObject(UserManager())
}
