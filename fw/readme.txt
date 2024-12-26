Steps to adjust the Vitis firmware solution to the specific paths after cloning:
	1. Open the solution (this folder)
	2. Select "Snake_platform" project
	3. Open project settings
	4. Go to Snake_platform > microblaze_0 > standalone_microblaze_0 > Board Support Package
	5. Regenerate BSP
	6. Build the Snake_platform project
	7. Select the "Snake_system" project
	8. Open project settings
	9. Click on "Switch Platform"
	10. In a pop-up window, select the "Snake_platform" and click Save

Now the application project should be ready for building.