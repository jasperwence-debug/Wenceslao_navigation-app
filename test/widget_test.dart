import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wenceslao_navigation_app/demo_auth.dart';
import 'package:wenceslao_navigation_app/main.dart';

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
  });

  testWidgets('Login with invalid credentials shows SnackBar and admin works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentApp());

    // Password visibility toggle
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);

    // Invalid credentials show SnackBar
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'wronguser',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'wrongpass',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    expect(find.text('Invalid username or password.'), findsOneWidget);

    // Valid default admin login opens MainScreen
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'admin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'admin123',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, Student!'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('Register new account and log in, while admin still works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentApp());

    await tester.tap(find.text("Don't have an account? Register"));
    await tester.pumpAndSettle();

    expect(find.text('Create an Account'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'jasper',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'secret123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'secret123',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    // Returned to LoginScreen
    expect(find.text('Welcome Back!'), findsOneWidget);

    // Log in with newly registered user
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'jasper',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'secret123',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, Student!'), findsOneWidget);
    expect(DemoAuth.login('admin', 'admin123'), isTrue);
  });

  testWidgets(
    'Bottom navigation switches between all 4 pages and preserves calculator state',
    (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'admin',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'admin123',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Home tab initially active
      expect(find.text('Welcome, Student!'), findsOneWidget);

      // Switch to Calculator tab
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Calculator'),
        ),
      );
      await tester.pump();
      expect(find.text('My Stateful Calculator'), findsOneWidget);

      // Perform calculation
      await tester.enterText(
        find.widgetWithText(TextField, 'First Number'),
        '12',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Second Number'),
        '8',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      expect(find.text('20.0'), findsOneWidget);

      // Switch to Profile tab
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Profile'),
        ),
      );
      await tester.pump();
      expect(find.text('My Profile'), findsOneWidget);
      expect(find.text('Jasper Wenceslao'), findsOneWidget);

      // Switch to Social Media tab and tap an account
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Social Media'),
        ),
      );
      await tester.pump();
      expect(find.text('Connect With Me'), findsOneWidget);

      await tester.tap(find.text('Facebook'));
      await tester.pump();
      expect(
        find.text('Selected account: Facebook: student.sample'),
        findsOneWidget,
      );

      // Switch back to Calculator tab and confirm state is preserved
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Calculator'),
        ),
      );
      await tester.pump();
      expect(find.text('20.0'), findsOneWidget);
    },
  );
}
