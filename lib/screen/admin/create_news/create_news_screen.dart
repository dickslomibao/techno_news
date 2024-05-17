import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/provider/news_controller.dart';
import 'package:techno_news/screen/admin/create_news/widgets/add_more_images.dart';
import 'package:techno_news/shared_widgets/buttons/button_widget.dart';
import 'package:techno_news/shared_widgets/textfields/text_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({Key? key}) : super(key: key);

  @override
  _CreateNewsScreenState createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  final title = TextEditingController();
  final content = TextEditingController();
  final controller = MultiImagePickerController(
    maxImages: 15,
    picker: (bool allowMultiple) async {
      final ImagePicker picker = ImagePicker();
      final pickedImages = await picker.pickMultiImage();
      return pickedImages
          .map((e) => ImageFile(
                UniqueKey()
                    .toString(), // A unique key required to track it in grid view.
                name: e.name,
                extension: e.name.split('.').last,
                path: e.path,
              ))
          .toList();
    },
  );
  @override
  void initState() {
    super.initState();
  }

  void showModalSelectCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a category',
              style: TextStyle(
                color: Color(0xfff6c7278),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Consumer<NewsCategoryController>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.categories.length,
                    itemBuilder: (context, index) {
                      final c = value.categories[index];
                      return CheckboxListTile(
                        value: value.selectedCategory.contains(c.id),
                        onChanged: (v) {
                          value.addSelectedCategory(c.id);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          value.categories[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(0),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0A2A55),
        title: const Text(
          'Create News',
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      color: Color(0xfff6c7278),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: showModalSelectCategory,
                    child: const Icon(
                      Icons.add,
                      color: Color(
                        0xff6c7278,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<NewsCategoryController>(
                builder: (context, value, child) {
                  return value.selectedCategory.isNotEmpty
                      ? SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.selectedCategory.length,
                            itemBuilder: (context, index) {
                              final c = value.categories.firstWhere(
                                (element) =>
                                    element.id == value.selectedCategory[index],
                              );
                              return Container(
                                margin: const EdgeInsets.only(
                                  right: 15,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff0A2A55),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        c.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<NewsCategoryController>()
                                              .removeSelectedCategory(value
                                                  .selectedCategory[index]);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          dashPattern: const [
                            27,
                            10,
                          ],
                          color: const Color(0xfff6c7278),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Select a category',
                                    style: TextStyle(
                                      color: Color(0xfff6c7278),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                label: "News Title",
                controller: title,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Content',
                style: TextStyle(
                  color: Color(0xfff6c7278),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffEFF0F6),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: content,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  maxLines: 200,
                  minLines: 10,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Images',
                style: TextStyle(
                  color: Color(0xfff6c7278),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MultiImagePickerView(
                draggable: true,
                shrinkWrap: true,
                controller: controller,
                padding: const EdgeInsets.all(0),
                addMoreButton: GestureDetector(
                  onTap: () async {
                    await controller.pickImages();
                  },
                  child: const AddMoreImagesWidget(),
                ),
                initialWidget: GestureDetector(
                  onTap: () async {
                    await controller.pickImages();
                  },
                  child: const AddMoreImagesWidget(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                  onPressed: () async {
                    final success =
                        await context.read<NewsController>().createNews(
                              images: controller.images.toList(),
                              categories: context
                                  .read<NewsCategoryController>()
                                  .selectedCategory,
                              title: title.text,
                              content: content.text,
                            );

                    if (context.mounted && success) {
                      Navigator.pop(context);
                    }
                  },
                  title: 'Publish news'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
