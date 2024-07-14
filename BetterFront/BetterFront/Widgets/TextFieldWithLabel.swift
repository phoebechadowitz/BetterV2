import SwiftUI

struct TextFieldWithLabel: View {
  let label: String
  @Binding var text: String
  var prompt: String? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(label)
        .modifier(FormLabel())
      TextField(label, text: $text, prompt: promptText())
        .padding(.bottom, 20)
        .disableAutocorrection(true)
    }
  }

  func promptText() -> Text? {
    if let prompt {
      return Text(prompt)
    } else {
      return nil
    }
  }
}

struct FormLabel: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .font(.caption)
  }
}

#Preview {
  TextFieldWithLabel(label: "Name", text: Binding.constant("Jon Phillips"), prompt: "Enter a name already!")
    .padding()
}


