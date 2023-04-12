import SwiftUI

struct UtilsRowView: View {
    let utilsItem: UtilsItem
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Toggle("", isOn: $isSelected)
                .toggleStyle(CheckboxToggleStyle())
                .frame(width: 50)
                .padding(10)

            VStack(alignment: .leading) {
                Text(utilsItem.value)
                    .font(.headline)

                HStack {
                    Text("Description: \(utilsItem.description)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(.bottom, 10)
        .overlay(Rectangle().stroke(Color.gray.opacity(0.5), lineWidth: 1).frame(width: nil, height: 1).padding(.top, -1), alignment: .bottom)
    }
}
