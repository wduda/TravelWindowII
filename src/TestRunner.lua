import "Turbine.Testing"

TestRunner = class()

function TestRunner.RunAllTests()
    local runner = Turbine.Testing.ShellTestRunner()
    runner:SetVerbose(true)

    -- Get all registered tests
    local allTests = Turbine.Testing.UnitTest.GetUnitTests()
    local testClasses = {}

    for name, testClass in pairs(allTests) do
        table.insert(testClasses, testClass)
    end

    if #testClasses == 0 then
        Turbine.Shell.WriteLine("<rgb=#FFFF99>No tests found. Is test mode enabled?</rgb>")
        return
    end

    Turbine.Shell.WriteLine("")
    Turbine.Shell.WriteLine("<rgb=#AAAAFF>========================================</rgb>")
    Turbine.Shell.WriteLine("<rgb=#AAAAFF>Running all TravelWindowII unit tests</rgb>")
    Turbine.Shell.WriteLine("<rgb=#AAAAFF>========================================</rgb>")
    Turbine.Shell.WriteLine("")

    local results = runner:RunUnitTestSet(testClasses)

    -- Print summary
    Turbine.Shell.WriteLine("")
    Turbine.Shell.WriteLine("<rgb=#AAAAFF>========================================</rgb>")
    Turbine.Shell.WriteLine(string.format(
        "<rgb=#AAAAFF>Test run completed: %d tests executed</rgb>",
        results:GetTestCount()
    ))
    Turbine.Shell.WriteLine("<rgb=#AAAAFF>========================================</rgb>")
    Turbine.Shell.WriteLine("")
end
