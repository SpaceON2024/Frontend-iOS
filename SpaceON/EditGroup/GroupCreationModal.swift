import SwiftUI
import Alamofire

struct GroupCreationModal: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var groupName: String = ""
    @State private var groupDescription: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("그룹명", text: $groupName)
                TextField("그룹 설명", text: $groupDescription)
            }
            .navigationBarItems(leading: Button(
                action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
                                ,trailing: Button("생성") {
                sendGroupData()
                print("\(groupName) \(groupDescription)")
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func sendGroupData() {
        let url = "https://spaceon.kro.kr/api/v1/group/new"
        let parameters: [String: String] = [
            "groupName": groupName,
            "groupContent": groupDescription
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                switch response.result {
                case .success:
                    print("Group created successfully \(groupName)")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

#Preview {
    GroupCreationModal()
}
